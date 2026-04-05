-- List all packages with status
vim.api.nvim_create_user_command('PackList', function()
  local lines = vim.iter(vim.pack.get())
      :map(function(p)
        local status = p.active and 'active' or 'unused'
        return string.format('  [%s] %s', status, p.spec.name)
      end)
      :totable()
  vim.notify('Packages:\n' .. table.concat(lines, '\n'), vim.log.levels.INFO)
end, { desc = 'List all packages with status' })

-- Delete unused packages
vim.api.nvim_create_user_command('PackClean', function()
  local unused = vim.iter(vim.pack.get())
      :filter(function(p) return not p.active end)
      :map(function(p) return p.spec.name end)
      :totable()

  if #unused == 0 then
    vim.notify('No unused packages', vim.log.levels.INFO)
    return
  end

  local msg = 'Unused packages:\n- ' .. table.concat(unused, '\n- ') .. '\n\nDelete them?'
  if vim.fn.confirm(msg, '&Yes\n&No', 2) ~= 1 then return end

  vim.pack.del(unused)
  vim.notify('Deleted ' .. #unused .. ' package(s)', vim.log.levels.INFO)
end, { desc = 'Delete unused packages' })

-- Toggle inlay hints
vim.api.nvim_create_user_command('ToggleInlayHints', function()
  vim.g.inlay_hints = not vim.g.inlay_hints
  vim.notify(string.format('%s inlay hints...', vim.g.inlay_hints and 'Enabling' or 'Disabling'), vim.log.levels.INFO)

  local mode = vim.api.nvim_get_mode().mode
  vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == 'n' or mode == 'v'))
end, { desc = 'Toggle inlay hints', nargs = 0 })
