local dap = require('dap');

vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, {
    desc = 'Toggle Breakpoint',
});

vim.keymap.set('n', '<leader>bc', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", {
    desc = 'Set Conditional Breakpoint',
});
vim.keymap.set('n', '<leader>bl', "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", {
    desc = 'Set Log BreakPoint',
});
vim.keymap.set('n', '<leader>br',"<cmd>lua require'dap'.clear_breakpoints()<cr>", {
    desc = 'Clear breakpoints',
});
vim.keymap.set('n', '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', {
    desc = 'List breakpoints',
});
