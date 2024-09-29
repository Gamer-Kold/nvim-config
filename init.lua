---@diagnostic disable: missing-fields
---@diagnostic disable: undefined-global

vim.g.mapleader = " "
vim.g.maplocalleader =  " "
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

local hotpot_path = vim.fn.stdpath("data") .. '/lazy/hotpot.nvim'
if not vim.loop.fs_stat(hotpot_path) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/rktjmp/hotpot.nvim.git',
    '--branch=v0.14.6', -- latest stable release
    hotpot_path,
  }
end
vim.opt.rtp:prepend(hotpot_path)
vim.opt.rtp:prepend(lazypath)
vim.loader.enable()
require("hotpot")
require('lazy').setup("plugin")
require("options")
require("lsp")
require("misc")
