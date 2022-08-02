local on_attach = function(client, bufnr)
end

require('lspconfig').rust_analyzer.setup {
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
            inlayHints = {
                enable = true,
                chainingHints = true,
            }
        }
    }
}
