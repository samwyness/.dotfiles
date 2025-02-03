return {
  'folke/trouble.nvim',
  opts = {},
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                ["<leader>tt"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
  -- config = function()
  --   require('trouble').setup {
  --     icons = false,
  --   }

  --   vim.keymap.set('n', '<leader>tt', function()
  --     require('trouble').toggle()
  --   end, { desc = 'Toggle the trouble list' })

  --   vim.keymap.set('n', '<leader>tn', function()
  --     require('trouble').next { skip_groups = true, jump = true }
  --   end, { desc = 'Go to the next diagnostic in the trouble list' })

  --   vim.keymap.set('n', '<leader>tp', function()
  --     require('trouble').previous { skip_groups = true, jump = true }
  --   end, { desc = 'Go to the previous diagnostic in the trouble list' })
  -- end,
}
