local git_blame = require 'gitblame'

require('lualine').setup {
    options = {
        theme = 'codedark',
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            { 'filename', path = 1 },
            { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
        },
        lualine_x = { 'filesize' },
        lualine_y = { 'location' },
        lualine_z = {}
    },
}
