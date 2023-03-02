vim.g.mapleader = ","
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = '{% for x in range(1, 256) %}+{{ x }},{% endfor %}+256'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.listchars = 'trail:·,nbsp:␣,tab:» "'
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.backspace = '2'
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Remove highlighting when entering insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
    pattern  = '*',
    callback = function()
        vim.cmd [[ call feedkeys("\<Cmd>noh\<cr>" , 'n') ]]
    end
})

-- Auto reformat
vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('auto_format', {}),
    callback = function()
        vim.lsp.buf.format {
            filter = function(client)
                -- Filter out tsserver which should be overriden by prettier from null_ls
                return client.name ~= "tsserver"
            end,
        }
    end
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('yank_highlight', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
    end,
})

-- Install plugins and colorscheme
require 'plugins'
require 'keys'

require 'languages.javascript'
require 'languages.lua'
require 'languages.python'
require 'languages.rust'
require 'languages.yaml'

-- Set color scheme and adjustments
vim.cmd [[
    hi LineNr       guibg=NONE  ctermbg=NONE
    hi Normal       guibg=NONE  ctermbg=NONE
    hi SignColumn   guibg=NONE  ctermbg=NONE
    hi FoldColumn   guibg=NONE  ctermbg=NONE
    hi VertSplit    guibg=NONE  ctermbg=NONE    guifg=234   ctermfg=234
    hi StatusLine   guibg=235   ctermbg=235
    hi StatusLineNC guibg=235   ctermbg=235
    hi RustCommentLineDoc guifg=248 ctermfg=248

    hi EndOfBuffer  guibg=232   ctermfg=232
    hi ColorColumn  guibg=232   ctermbg=232
    hi CursorLine   guibg=233   ctermbg=233

    hi DiffText     guibg=22    ctermbg=22      cterm=NONE
    hi DiffAdd      guibg=22    ctermbg=22
    hi DiffChange   guibg=234   ctermbg=234
    hi DiffDelete   guibg=234   ctermbg=234
]]
