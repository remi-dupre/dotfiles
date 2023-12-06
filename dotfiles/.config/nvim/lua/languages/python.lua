vim.api.nvim_create_autocmd('FileType', {
    pattern = "python",
    callback = function()
        vim.cmd [[ set tw=120 ]]
    end
})

require('lspconfig').ruff_lsp.setup {
    init_options = {
        settings = {
            args = {},
        }
    }
}
