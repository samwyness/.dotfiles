return {
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'filipdutescu/renamer.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { -- optional cmp completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          })
        end,
      },
      'hrsh7th/cmp-nvim-lsp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      'j-hui/fidget.nvim',
      'filipdutescu/renamer.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      local lspconfig = require 'lspconfig'

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', {}, capabilities, require('cmp_nvim_lsp').default_capabilities())

      local inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      }

      -- Enable the following language servers
      local servers = {
        gopls = {},
        html = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              hint = { enable = true },
            },
          },
        },

        ts_ls = {
          settings = {
            completion = {
              completeFunctionCalls = true,
            },
            javascript = {
              inlayHints = inlayHints,
            },
            typescript = {
              inlayHints = inlayHints,
            },
          },
        },

        eslint = {
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },
      }

      for name, opts in pairs(servers) do
        opts.capabilities = capabilities
        lspconfig[name].setup(opts)
      end

      -- Add keymaps when lsp is attached to the buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('samwyness-lsp-attach', { clear = true }),
        callback = function(event)

          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
          })

          map('<leader>cR', require('renamer').rename, 'Rename symbol')

          map('<leader>ca', vim.lsp.buf.code_action, 'Code Actions')

          -- Typescript specific code actions
          map('<leader>co', function()
            vim.lsp.buf.code_action {
              apply = true,
              context = {
                only = { 'source.organizeImports.ts' },
                diagnostics = {},
              },
            }
          end, 'Organize imports')

          map('<leader>cr', function()
            vim.lsp.buf.code_action {
              apply = true,
              context = {
                only = { 'source.removeUnused.ts' },
                diagnostics = {},
              },
            }
          end, 'Remove unused imports')

          map('<leader>h', function()
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(nil), nil) 
          end, 'Toggle inlay hints')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Make diagnostics look better
      vim.diagnostic.config {
        float = {
          focusable = true,
          source = true,
          style = 'minimal',
          border = 'double',
        },
      }
    end,
  },
}
