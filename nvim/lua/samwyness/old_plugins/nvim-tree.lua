local map = vim.api.nvim_set_keymap

return {
    'nvim-tree/nvim-tree.lua',
    config = function()
        require('nvim-tree').setup {
            view = {
                width = 42
            },

            vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<enter>', {
                desc = 'Toggle the file explorer'
            }),
            vim.keymap.set('n', '<C-f>', ':NvimTreeFindFileToggle<enter>', {
                desc = 'Toggle the file explorer at current file'
            }),
            vim.keymap.set('n', '<C-.>', ':NvimTreeResize +20<enter>', {
                desc = 'Increase file explorer size'
            }),
            vim.keymap.set('n', '<C-,>', ':NvimTreeResize -20<enter>', {
                desc = 'Derease file explorer size'
            }),
            vim.keymap.set('n', '<leader>fo', '<cmd>NvimTreeOpen<enter>', {
                desc = '[F]ile explorer [O]pen'
            }),
            vim.keymap.set('n', '<leader>fc', '<cmd>NvimTreeClose<CR>', {
                desc = '[F]ile explorer [C]lose'
            }),
            vim.keymap.set('n', '<leader>fC', '<cmd>NvimTreeCollapse<CR>', {
                desc = '[F]ile explorer [C]ollapse'
            }),
            vim.keymap.set('n', '<leader>fr', '<cmd>NvimTreeRefresh<CR>', {
                desc = '[F]ile explorer [R]efresh'
            })
        }
    end
}
