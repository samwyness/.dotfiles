-- Install with
-- mac: brew install lua-language-server

return {
  -- Command and arguments to start the server. This assumes the server is in your PATH.
  cmd = { "lua-language-server" },

  -- Filetypes the server should automatically attach to.
  filetypes = { "lua" },

  -- Root directory markers for projects (optional, helps the server locate the project root)
  root_markers = { '.luarc.json', '.luarc.jsonc' },

  -- General settings for the language server
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}
