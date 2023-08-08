local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
 -- vim.keymap.set('n', '<C-g>','<cmd>Telescope git_files<CR>')
vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>')
vim.keymap.set('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>')

require('telescope').load_extension('media_files')

vim.keymap.set('n', '<leader>me', '<cmd>Telescope media_files<CR>')

local trouble = require("trouble.providers.telescope")


require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules"
        },
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    }
}
