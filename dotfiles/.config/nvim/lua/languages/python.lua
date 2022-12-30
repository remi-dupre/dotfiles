vim.api.nvim_create_autocmd('FileType', {
    pattern = "python",
    callback = function()
        vim.cmd [[ set tw=100 ]]
    end
})

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
