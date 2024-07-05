vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Set no highlight search by default
vim.o.hlsearch = false

-- Key mappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap('n', '.h', ':set hlsearch<CR>', opts)
keymap('n', '.n', ':set nohlsearch<CR>', opts)
keymap('n', '.r', ':source ~/.config/nvim/init.lua<CR>', opts)
keymap('n', '.y', '"+y', opts)
keymap('v', '.y', '"+y', opts)
keymap('n', 'e', 'k', opts)
keymap('n', 'i', 'l', opts)
keymap('n', 'a', 'j', opts)
keymap('n', 't', 'i', opts)
keymap('n', 's', 'a', opts)
keymap('n', 'f', 'd', opts)
keymap('n', 'l', 'e', opts)
keymap('n', 'm', 'x', opts)
keymap('v', 'm', 'x', opts)
keymap('n', 'i', 'l', opts)
keymap('n', 'a', 'j', opts)
keymap('v', 'i', 'l', opts)
keymap('v', 'a', 'j', opts)
keymap('v', 'e', 'k', opts)

-- Auto commands
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.conf"},
    command = "set filetype=conf"
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.yuck", "*.kdb"},
    command = "set filetype=lisp"
})
