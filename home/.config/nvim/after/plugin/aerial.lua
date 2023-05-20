local aerial = require('aerial')
require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '}', aerial.next, {buffer = bufnr})
    vim.keymap.set('n', '{', aerial.prev, {buffer = bufnr})
  end
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set('n', '<leader>a', function()
    aerial.toggle({focus=true})
end)
