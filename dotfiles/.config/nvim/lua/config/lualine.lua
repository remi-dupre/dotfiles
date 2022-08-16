require('lualine').setup {
    options = {
        theme = 'codedark',
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filesize' },
        lualine_y = { 'location' },
        lualine_z = {}
    },
}
