require('lspconfig').pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                black = { enabled = true },
                pylint = { enabled = true },
            }
        }
    }
}
