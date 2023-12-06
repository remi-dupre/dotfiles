local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Color scheme
    {
        'jacoborus/tender.vim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme tender]]
        end,
    },

    --  Adds file type icons to Vim plugins
    'kyazdani42/nvim-web-devicons',

    --  A file explorer tree for neovim written in lua
    'kyazdani42/nvim-tree.lua',

    --  Quickstart configs for Nvim LSP
    'neovim/nvim-lspconfig',

    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    'jose-elias-alvarez/null-ls.nvim',

    -- A completion plugin for neovim coded in Lua
    'hrsh7th/cmp-buffer',       -- nvim-cmp source for buffer words
    'hrsh7th/cmp-cmdline',      -- nvim-cmp source for vim's cmdline
    'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
    'hrsh7th/cmp-path',         --  nvim-cmp source for path
    'hrsh7th/nvim-cmp',         -- Autocompletion plugin
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip',         -- Snippets plugin
    'onsails/lspkind.nvim',     --  vscode-like pictograms for neovim lsp completion items

    -- Find, Filter, Preview, Pick. All lua, all the time
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Nvim Treesitter configurations and abstraction layer
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },

    -- Indent guides for Neovim
    'lukas-reineke/indent-blankline.nvim',

    -- Autopairs for neovim written in lua
    'windwp/nvim-autopairs',

    -- Git integration for buffers
    'lewis6991/gitsigns.nvim',

    -- A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git
    -- web frontend hosts. Inspired by tpope/vim-fugitive's :GBrowse
    {
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
    },

    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
    'nvim-lualine/lualine.nvim',

    -- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat,
    -- left-right/up-down motions, hooks, and more
    'numToStr/Comment.nvim',

    -- Git Blame plugin for Neovim written in Lua
    'f-person/git-blame.nvim',

    -- Vim configuration for Fish
    'nickeb96/fish.vim',

    -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with
    -- Github Copilot
    -- 'zbirenbaum/copilot.lua',
})

require 'config.cmp'
-- require 'config.copilot'
require 'config.gitblame'
require 'config.gitlinker'
require 'config.ident-blankline'
require 'config.lualine'
require 'config.null_ls'
require 'config.telescope'
require 'config.treesitter'

-- Config-free plugins
require('Comment').setup()
require('gitsigns').setup()
require('nvim-autopairs').setup()
require('nvim-tree').setup()
