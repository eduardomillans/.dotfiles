local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- User autocmds
local group = augroup("UserAutocmds", {})

autocmd("FileType", { pattern = "*", command = "setlocal autoindent", group = group })
autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.blade.php", command = "set filetype=blade", group = group })
autocmd("TermOpen", { pattern = "*", command = "setlocal norelativenumber", group = group })
autocmd("TextYankPost", {
    pattern  = "*",
    callback = function ()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 250 })
    end,
    group    = group
})
