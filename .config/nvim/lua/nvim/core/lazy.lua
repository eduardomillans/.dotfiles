local global   = require("nvim.core.global")
local util     = require("nvim.lib.util")

-- Bootstrap
local lazypath = util.path(global.dir.nvim.data, "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Setup
require("lazy").setup({
    spec = "nvim.plugins",
    install = {
        colorscheme = { "gruvbox", "habamax" },
    },
    change_detection = {
        notify = false,
    },
})
