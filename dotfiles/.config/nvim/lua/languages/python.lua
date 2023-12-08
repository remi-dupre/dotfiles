vim.api.nvim_create_autocmd('FileType', {
    pattern = "python",
    callback = function()
        vim.cmd [[ set tw=120 ]]
    end
})


local lspconfig = require('lspconfig')
lspconfig.ruff_lsp.setup {}

lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                autopep8 = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                yapf = { enabled = false },
                rope_autoimport = { enabled = true },
                rope_completion = { enabled = true },
            }
        }
    },
    on_attach = function(client, _)
        -- Disable formatting in favor of ruff
        client.server_capabilities.documentFormattingProvider = false
    end,
}
