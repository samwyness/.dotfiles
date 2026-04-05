-- Rose Pine
require('rose-pine').setup { styles = { italic = false } }
vim.cmd.colorscheme('rose-pine')

-- Snacks
if not vim.g.snacks_loaded then
  require('snacks').setup {
    explorer = { enabled = true },
    gh = { enabled = true },
    git = { enabled = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        lsp_references = { format = "filename" },
        lsp_definitions = { format = "filename" },
      },
    },
    statuscolumn = { enabled = true },
  }
  vim.g.snacks_loaded = true
end

-- Treesitter (install parsers, highlight via builtin vim.treesitter.start)
local parsers = {
  'bash', 'css', 'html', 'javascript', 'json', 'lua',
  'markdown', 'markdown_inline', 'tsx', 'typescript', 'vim', 'vimdoc',
}
require('nvim-treesitter').install(parsers)
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- Autocomplete
require('mini.completion').setup {
  lsp_completion = { source_func = 'omnifunc' },
}
