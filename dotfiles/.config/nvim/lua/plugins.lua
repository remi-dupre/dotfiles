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
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
 
    -- Find, Filter, Preview, Pick. All lua, all the time
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    --  Nvim Treesitter configurations and abstraction layer
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
end)

require('nvim-autopairs').setup()
require('nvim-tree').setup()
require('gitsigns').setup()

require 'config.cmp'
require 'config.ident-blankline'
require 'config.telescope'
require 'config.treesitter'
