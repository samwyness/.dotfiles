-- Leader keys (space)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Prompt to save instead of erroring on unsaved changes
vim.o.confirm = true

-- Highlight current line
vim.o.cursorline = true

-- Line numbers (relative to cursor)
vim.o.number = true
vim.o.relativenumber = true

-- Tabs & indentation (2 spaces)
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

-- Always show sign column (diagnostics, git signs)
vim.o.signcolumn = 'yes:1'

-- Vertical guide at column 80
vim.o.colorcolumn = '80'

-- Single global statusline
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- Use system clipboard
vim.o.clipboard = 'unnamedplus'

-- Rounded borders on floating windows
vim.o.winborder = 'rounded'

-- Keep 10 lines visible above/below cursor
vim.o.scrolloff = 10

-- Timeouts (CursorHold, key sequences, terminal key codes)
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- Persist undo history across sessions
vim.o.undofile = true
-- vim.o.swapfile = false
-- vim.o.backup = false

-- Search (case-insensitive unless uppercase, no persistent highlight)
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.inccommand = 'split'

-- Spell check
vim.o.spelllang = 'en_us'
vim.o.spell = true

-- Disable unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Disable snacks animations
vim.g.snacks_animate = false

-- Disabled options (uncomment to enable)
vim.g.have_nerd_font = false
vim.o.wrap = false
vim.o.list = true

-- Packages
vim.pack.add {
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/rose-pine/neovim',
  { src = 'https://github.com/theprimeagen/harpoon', version = 'harpoon2' },
}

--- LSP
local servers = { 'lua_ls', 'ts_ls', 'eslint' }
vim.lsp.enable(servers)
vim.lsp.config('*', {
  handlers = {
    -- Truncate long inlay hints
    ['textDocument/inlayHint'] = function(err, result, ctx, config)
      local max_hint_len = 45
      if result then
        for _, hint in ipairs(result) do
          if type(hint.label) == 'string' and #hint.label > max_hint_len then
            hint.label = hint.label:sub(1, max_hint_len - 1) .. '…'
          elseif type(hint.label) == 'table' then
            local full = table.concat(vim.iter(hint.label):map(function(part) return part.value end):totable())
            if #full > max_hint_len then
              hint.label = full:sub(1, max_hint_len - 1) .. '…'
            end
          end
        end
      end
      return vim.lsp.handlers['textDocument/inlayHint'](err, result, ctx, config)
    end,
  },
})

-- Setup
require('plugins')
require('keymap')
require('autocmds')
require('commands')
