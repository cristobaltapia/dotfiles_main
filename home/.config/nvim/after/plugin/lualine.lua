local function custom_component_str()
  return [[buffers]]
end

require('lualine').setup(
    {
        extensions = { 'quickfix', 'fugitive' },
        tabline = {
            lualine_a = { 'buffers' },
            lualine_z = { custom_component_str },
        },
    }
)
