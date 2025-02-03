return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
  keys = {
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
  },
}
