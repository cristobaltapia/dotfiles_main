vim.cmd(
    [[
    function! g:Open_browser(url)
    "silent exe 'silent !gnome-www-browser --private-instance ' . a:url . " &"
    silent exe 'silent !epiphany --private-instance ' . a:url . " &"
    endfunction
    ]]
)

--[[ local function open_browser(url)
    io.popen("epiphany --private-instance " .. url .. " &")
end ]]
vim.g.mkdp_browserfunc = 'g:Open_browser'

vim.g.mkdp_filetypes = { 'pandoc', 'markdown', 'markdown.pandoc', 'wiki' }
vim.g.mkdp_auto_close = false
