-- Eclipse Java development tools (JDT) Language Server downloaded from:
-- https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.21.0/jdt-language-server-1.21.0-202303161431.tar.gz
local jdtls = require('jdtls')
-- Change or delete this if you don't depend on nvim-cmp for completions.
local cmp_nvim_lsp = require('cmp_nvim_lsp')

-- Change jdtls_path to wherever you have your Eclipse Java development tools (JDT) Language Server downloaded to.
local jdtls_path = 'D:/Java/jdt-language-server'
local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

-- for completions
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)

-- for debugging
local java_debugger_path = "D:/Java/java-debug-0.47.0"
local bundles = {
    vim.fn.glob(java_debugger_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
}

local function get_config_dir()
    -- Unlike some other programming languages (e.g. JavaScript)
    -- lua considers 0 truthy!
    if vim.fn.has('linux') == 1 then
        return 'config_linux'
    elseif vim.fn.has('mac') == 1 then
        return 'config_mac'
    else
        return 'config_win'
    end
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    settings = {
        java = {
            format = {
                settings = {
                    url = os.getenv('LOCALAPPDATA') .. "/nvim/lang-servers/eclipse-java-google-style.xml",
                    profile = "GoogleStyle"
                }
            },
        }
    },
    capabilities = capabilities,
    cmd = { -- This sample path was tested on Cygwin, a "unix-like" Windows environment.
        -- Please contribute to this Wiki if this doesn't work for another Windows
        -- environment like [Git for Windows](https://gitforwindows.org/) or PowerShell.
        -- JDTLS currently needs Java 17 to work, but you can replace this line with "java"
        -- if Java 17 is on your PATH.
        "D:/Java/java-17.0.5+8/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:D:/Java/jdt-language-server/lombok.jar",
        "-jar", launcher_jar,
        "-configuration", vim.fs.normalize(jdtls_path .. '/' .. get_config_dir()),
        "-data", vim.fn.expand('~/.cache/jdtls-workspace/') .. workspace_dir },
    root_dir = vim.fs.dirname(vim.fs.find({ 'pom.xml', '.git' }, {
        upward = true
    })[1]),
    init_options = {
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities#extended-client-capabilities
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
        bundles = bundles
    },
    on_attach = function(client, bufnr)
        -- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L88-L94
        local opts = {
            silent = true,
            buffer = bufnr
        }
        vim.keymap.set('n', "<C-o>", jdtls.organize_imports, {
            desc = 'Organize imports',
            buffer = bufnr
        })

        -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
        -- you make during a debug session immediately.
        -- Remove the option if you do not want that.
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })

        -- Should 'd' be reserved for debug?
        vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
        vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
        vim.keymap.set('n', '<leader>rv', jdtls.extract_variable_all, {
            desc = 'Extract variable',
            buffer = bufnr
        })
        vim.keymap.set('v', '<leader>rm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], {
            desc = 'Extract method',
            buffer = bufnr
        })
        vim.keymap.set('n', '<leader>rc', jdtls.extract_constant, {
            desc = 'Extract constant',
            buffer = bufnr
        })
    end
}

jdtls.start_or_attach(config)
