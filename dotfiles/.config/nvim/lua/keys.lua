vim.api.nvim_set_keymap('n', ';', ':Telescope find_files<CR>', {})

-- LSP
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)

-- NvimTree
vim.api.nvim_set_keymap('n', '<C-x>', ':NvimTreeToggle<CR>', { silent = true })

-- Git
vim.keymap.set('n', '<C-l>', require('gitsigns').prev_hunk)
vim.keymap.set('n', '<C-h>', require('gitsigns').next_hunk)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev)
