vim.g.vimwiki_pubs_config = { vim.env.HOME .. "/.config/pubs/main_library.conf",
    vim.env.HOME .. "/.config/pubs/misc_library.conf" }

vim.g.wiki_root = '~/Nextcloud/Notes'
vim.g.wiki_map_text_to_link = 'WikivimFile'
vim.g.wiki_filetypes = { 'wiki' }
vim.g.wiki_link_target_type = 'wiki'
vim.g.wiki_link_extension = ''
vim.g.wiki_select_method = 'fzf'

--[[ function WikivimFile(text) abort
    return [substitute(tolower(a:text), '\s\+', '-', 'g'), a:text]
endfunction ]]
