vim.cmd 'colorscheme tender'
vim.cmd 'highlight LineNr     ctermbg=NONE guibg=NONE'
vim.cmd 'highlight Normal     ctermbg=NONE guibg=NONE'
vim.cmd 'highlight SignColumn ctermbg=NONE guibg=NONE'

vim.g.mapleader = ","
vim.opt.colorcolumn = '100'
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
vim.cmd 'autocmd InsertEnter * setlocal nohlsearch'

-- Auto reformat
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format {
            async = true,
            filter = function(client)
                -- Filter out tsserver which should be overriden by prettier from null_ls
                return client.name ~= "tsserver"
            end,
        }
    end
})

require 'keys'
require 'plugins'

require 'languages.javascript'
require 'languages.lua'
require 'languages.python'
require 'languages.rust'
require 'languages.yaml'
