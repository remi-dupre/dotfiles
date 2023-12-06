vim.api.nvim_set_keymap('n', ';', ':Telescope find_files<CR>', {})

-- LSP
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader><leader>', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

-- NvimTree
vim.api.nvim_set_keymap('n', '<C-x>', ':NvimTreeFocus<CR>', { silent = true })

-- Git
vim.keymap.set('n', '<C-h>', require('gitsigns').prev_hunk)
vim.keymap.set('n', '<C-l>', require('gitsigns').next_hunk)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev)

-- Copilot
-- vim.keymap.set('i', '<A-h>', require("copilot.suggestion").prev)
-- vim.keymap.set('i', '<A-l>', require("copilot.suggestion").next)
-- vim.keymap.set('i', '<A-j>', require("copilot.suggestion").accept_line)
-- vim.keymap.set('i', '<A-m>', require("copilot.suggestion").accept)
-- vim.keymap.set('i', '<A-k>', require("copilot.suggestion").accept_word)
