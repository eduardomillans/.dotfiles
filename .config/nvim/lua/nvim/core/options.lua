local global = require("nvim.core.global")
local util   = require("nvim.lib.util")

local opts   = {
    -- Global
    exrc           = true,
    hidden         = true,
    termguicolors  = true,
    clipboard      = "unnamedplus",
    mouse          = { a = true },
    guicursor      = "",
    backup         = false,
    writebackup    = false,
    swapfile       = false,
    directory      = util.path(global.dir.home, ".cache", "nvim", "swap"),
    undodir        = util.path(global.dir.home, ".cache", "nvim", "undo"),
    backupdir      = util.path(global.dir.home, ".cache", "nvim", "backup"),
    viewdir        = util.path(global.dir.home, ".cache", "nvim", "view"),
    laststatus     = 3,
    history        = 2000,
    updatetime     = 250,
    fillchars      = { vert = " " },
    whichwrap      = function (opt)
        opt:append({ ["<"] = true, [">"] = true, ["["] = true, ["]"] = true, ["h"] = true, ["l"] = true })
    end,
    splitbelow     = true,
    splitright     = true,
    incsearch      = true,
    hlsearch       = false,
    backspace      = { "indent", "eol", "start" },
    completeopt    = { "menu", "menuone", "noselect" },
    showmode       = true,
    showcmd        = true,
    shortmess      = function (opt)
        opt:append({ c = true })
    end,
    pumheight      = 15,
    cmdwinheight   = 15,

    -- Buffer
    textwidth      = global.opt.textwidth,
    smartindent    = true,
    expandtab      = true,
    tabstop        = global.opt.indentation,
    shiftwidth     = global.opt.indentation,

    -- Window
    wrap           = false,
    relativenumber = true,
    cursorline     = true,
    signcolumn     = "no",
}

-- Set options
for k, v in pairs(opts) do
    if type(v) == "function" then
        v(vim.opt[k])
    else
        vim.opt[k] = v
    end
end
