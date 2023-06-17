local animate = require('mini.animate')
require('mini.trailspace').setup()
require('mini.indentscope').setup()
require('mini.animate').setup({
    cursor = { enable = false },
    resize = { enable = true },
    scroll = { enable = false, timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }) }
})
