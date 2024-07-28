local util         = require("nvim.lib.util")

local _cwd         = vim.uv.cwd()
local _status      = { modified = "[+]", readonly = "[-]", unnamed = "[no name]", terminal = "[terminal]", netrw = "[netrw]" }

local filename     = function ()
    local name = vim.api.nvim_buf_get_name(0)

    if #name == 0 then
        name = _status.unnamed
    elseif name:match("term") then
        name = _status.terminal
    elseif vim.bo.filetype == "netrw" then
        name = _status.netrw
    else
        name = util.replace(name, _cwd, ""):sub(2, -1)
    end

    return ("%s%s"):format(name, (vim.bo.readonly or not vim.bo.modifiable) and _status.readonly or (vim.bo.modified and _status.modified or ""))
end

local diagnostics  = function ()
    local diagnostics = vim.diagnostic.get(0)

    if #diagnostics == 0 then
        return ""
    end

    local diagnostic = diagnostics[1]
    local severity   = vim.diagnostic.severity[diagnostic.severity]

    return "%#Diagnostic" .. severity .. "#▊"
end

local git          = function ()
    local file = ("%s/.git/HEAD"):format(_cwd)

    if vim.fn.filereadable(file) == 0 then
        return ""
    end

    local head   = vim.fn.readfile(file)[1]
    local branch = vim.fn.substitute(head, [[\C^ref: \%(refs/\%(heads/\|remotes/\|tags/\)\=\)\=]], "", "")

    return #branch > 0 and ("[%s]"):format(branch) or branch
end

local filetype     = function ()
    local ft = vim.bo.filetype

    return #ft > 0 and ft or "no ft"
end

local fileencoding = function ()
    return #vim.bo.fileencoding ~= 0 and vim.bo.fileencoding or vim.o.encoding
end

local fileformat   = function ()
    return vim.bo.fileformat
end

local location     = function ()
    return "%l:%c"
end

---@class Statusline
---@field public components table
local Statusline   = {}

function Statusline.__index(_, key)
    return Statusline[key]
end

---Parse arguments
---@param args table
---@return table
function Statusline.__parse(args)
    vim.validate({
        section = { args.section, { "string", "function" } },
        hl = { args.hl, { "string", "nil" } },
        left_sep = { args.hl, { "string", "nil" } },
        rigth_sep = { args.hl, { "string", "nil" } },
        cond = { args.cond, { "function", "nil" } },
    })

    local section, cond, hl, left_sep, right_sep = args.section, args.cond, "%#StatusLine#", " ", " "

    if type(section) == "function" then
        section = section()
    end

    if args.hl then
        hl = util.replace(hl, "StatusLine", args.hl)
    end

    if args.left_sep then
        left_sep = args.left_sep
    end

    if args.right_sep then
        right_sep = args.right_sep
    end

    return { section, cond, hl, left_sep, right_sep }
end

---Create instance of Statusline
---@return Statusline
function Statusline:new()
    local instance = {
        components = {},
    }

    return setmetatable(instance, self)
end

---Append a component
---@param args table
function Statusline:add(args)
    local section, cond, hl, left_sep, right_sep = unpack(self.__parse(args))

    if type(cond) == "function" then
        if not cond(section) then
            return
        end
    end

    local component = table.concat({
        "%#StatusLine#", left_sep, hl, section, "%#StatusLine#", right_sep,
    })

    table.insert(self.components, component)
end

---Build statusline
---@return string
function Statusline:build()
    return table.concat(self.components)
end

_G.build_statusline = function ()
    local instance = Statusline:new()

    instance:add({ section = filename, left_sep = "" })
    instance:add({ section = "%=" })

    pcall(function ()
        local lsp_progress = require("lsp-progress")
        instance:add({ section = lsp_progress.progress })
    end)

    instance:add({ section = git })
    instance:add({ section = filetype })
    instance:add({ section = fileencoding })
    instance:add({ section = fileformat })
    instance:add({ section = location, right_sep = "" })
    instance:add({
        section = diagnostics,
        left_sep = " ",
        right_sep = "",
        cond = function (section)
            return #section > 0
        end,
    })

    return instance:build()
end

-- Autocommand
vim.cmd([[
  augroup StatusLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal statusline=%!v:lua.build_statusline()
  augroup END
]])
