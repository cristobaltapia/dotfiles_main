-- Bootstrap installation of lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Define the leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load further configurations (mappings, sets, etc)
require("tapia")
-- Load lazy.nvim
-- local plugins = require("plugins")
require("lazy").setup("plugins")
