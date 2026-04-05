-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('samwyness/yank_highlight', { clear = true }),
  desc = 'Highlight on yank',
  callback = function()
    vim.hl.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})

-- Disable autocomplete in Snacks picker/input buffers
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('samwyness/disable_completion', { clear = true }),
  pattern = { 'snacks_input', 'snacks_picker_input' },
  callback = function(ev)
    vim.b[ev.buf].minicompletion_disable = true
  end,
})

-- Format & fix on save
local format_group = vim.api.nvim_create_augroup('samwyness/format_on_save', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = format_group,
  pattern = '*.lua',
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = format_group,
  callback = function()
    if not vim.lsp.get_clients({ name = 'eslint', bufnr = 0 })[1] then return end
    vim.lsp.buf.code_action {
      ---@diagnostic disable-next-line: assign-type-mismatch
      context = { only = { 'source.fixAll.eslint' }, diagnostics = {} },
      apply = true,
    }
  end,
})
