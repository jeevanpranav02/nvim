local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'cssls',
    'jdtls',
    'html',
    'yamlls'
})

lsp.skip_server_setup({'jdtls'})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local function nnoremap(rhs, lhs, bufopts, desc)
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

lsp.on_attach(function(client, bufnr)

    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
    }
    nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
    nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
    nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
    nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
    nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
    nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
    nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
    nnoremap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts, "List workspace folders")
    nnoremap('<leader>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
    nnoremap('<leader>rn', vim.lsp.buf.rename, bufopts, "Rename")
    nnoremap('<leader>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
    vim.keymap.set('v', "<leader>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>", {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = "Code actions"
    })
    nnoremap('<leader>f', function()
        vim.lsp.buf.format {
            async = true
        }
    end, bufopts, "Format file")

    nnoremap('<leader>vd', vim.diagnostic.open_float, bufopts, "Open Diagnostics")
    nnoremap('[d', vim.diagnostic.goto_next, bufopts, "Goto Next")
    nnoremap(']d', vim.diagnostic.goto_prev, bufopts, "Goto Prev")
    nnoremap('<A-`>', vim.lsp.buf.workspace_symbol, bufopts, "Show workspace symbols")

end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

