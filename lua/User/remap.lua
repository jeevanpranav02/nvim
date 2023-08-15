vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Moving Lines Up and Down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor will stay in place
vim.keymap.set("n", "J", "mzJ`z")

-- Half page jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Cursor will stay in middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever lets copy the current buffer and deletes the pasted buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- Allows to copy to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Wanna figure out what this does
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Allows to switch projects // Need to implement
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- This replaces the current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- This formats the entire file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- nvim-tree
vim.keymap.set('n', '<leader>nn', "<cmd>NvimTreeToggle<cr>", {
    desc = 'Open file browser'
})
vim.keymap.set('n', '<leader>nf', "<cmd>NvimTreeFindFile<cr>", {
    desc = 'Find in file browser'
})
