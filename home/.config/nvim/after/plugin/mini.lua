local animate = require('mini.animate')
require('mini.trailspace').setup()
require('mini.indentscope').setup()
require('mini.animate').setup({
    cursor = { enable = false },
    scroll = { timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }) }
})
