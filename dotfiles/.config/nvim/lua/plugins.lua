require('packer').startup(function(use)
    -- Self management for packer
    use 'wbthomason/packer.nvim'

    -- Color scheme
    use 'jacoborus/tender.vim'

    --  Adds file type icons to Vim plugins
    use 'kyazdani42/nvim-web-devicons'

    --  A file explorer tree for neovim written in lua
    use 'kyazdani42/nvim-tree.lua'

    --  Quickstart configs for Nvim LSP
    use 'neovim/nvim-lspconfig'

    -- A completion plugin for neovim coded in Lua
    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
    use 'hrsh7th/cmp-cmdline' -- nvim-cmp source for vim's cmdline
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-path' --  nvim-cmp source for path
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'onsails/lspkind.nvim' --  vscode-like pictograms for neovim lsp completion items

    -- Find, Filter, Preview, Pick. All lua, all the time
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Nvim Treesitter configurations and abstraction layer
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- Indent guides for Neovim
    use 'lukas-reineke/indent-blankline.nvim'

    -- Autopairs for neovim written in lua
    use 'windwp/nvim-autopairs'

    -- Git integration for buffers
    use 'lewis6991/gitsigns.nvim'

    -- A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git
    -- web frontend hosts. Inspired by tpope/vim-fugitive's :GBrowse
    use {
        'ruifm/gitlinker.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }

    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
    use 'nvim-lualine/lualine.nvim'

    -- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat,
    -- left-right/up-down motions, hooks, and more
    use 'numToStr/Comment.nvim'

    -- Git Blame plugin for Neovim written in Lua
    use 'f-person/git-blame.nvim'

    -- Vim configuration for Fish
    use 'nickeb96/fish.vim'
end)

require 'config.cmp'
require 'config.gitlinker'
require 'config.ident-blankline'
require 'config.lualine'
require 'config.telescope'
require 'config.treesitter'
require 'config.gitblame'

-- Config-free plugins
require('Comment').setup()
require('gitsigns').setup()
require('nvim-autopairs').setup()
require('nvim-tree').setup()
