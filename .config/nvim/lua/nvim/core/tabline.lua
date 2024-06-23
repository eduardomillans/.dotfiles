local setlabel = function (n)
    local list  = vim.fn.tabpagebuflist(n)
    local winnr = vim.fn.tabpagewinnr(n)
    local buf   = list[winnr]

    local name  = vim.fn.bufname(buf)

    if #name == 0 then
        return "[no name]"
    end

    if name:match("term") then
        return "[terminal]"
    end

    if vim.bo[buf].filetype == "netrw" then
        return "[netrw]"
    end

    return vim.fn.fnamemodify(name, ":t")
end

_G.build_tabline = function ()
    local tabline = {}

    for i = 1, vim.fn.tabpagenr("$") do
        table.insert(tabline, i == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#")
        table.insert(tabline, ("%%%dT"):format(i))
        table.insert(tabline, (" %d:[%s] "):format(i, setlabel(i)))
        table.insert(tabline, "%#TabLineFill#%T")
    end

    return table.concat(tabline)
end

vim.cmd([[set tabline=%!v:lua.build_tabline()]])
