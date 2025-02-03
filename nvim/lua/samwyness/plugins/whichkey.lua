return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup {
      icons = {
        mappings = false,
      },
    }

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', group = 'Code' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>p', group = 'Project' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Trouble list' },
    }
  end,
}