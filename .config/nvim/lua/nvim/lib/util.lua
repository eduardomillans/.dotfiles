local global = require("nvim.core.global")

local M = {}

---Concat filesystem path
---@param ... string
---@return string
M.path = function (...)
    return table.concat({ ... }, global.sep)
end

---Replace string
---@param str string
---@param what string
---@param with string
---@return string, integer
M.replace = function (str, what, with)
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1")
    with = string.gsub(with, "[%%]", "%%%%")
    return string.gsub(str, what, with)
end

---Capitalize first character
---@param str string
---@return string
M.capitalize = function (str)
    return (str:gsub("^%l", string.upper))
end

---Conver hex to rgb color
---@param str string
---@return table
M.hex_to_rgb = function (str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    str = string.lower(str)

    assert(string.find(str, pat) ~= nil, "hex_to_rgb: invalid str: " .. tostring(str))

    local red, green, blue = string.match(str, pat)

    return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

---Get the blend of a color
---@param fg string
---@param bg string
---@param alpha number
---@return string
M.blend = function (fg, bg, alpha)
    local _bg = M.hex_to_rgb(bg)
    local _fg = M.hex_to_rgb(fg)

    local blend = function (i)
        local ret = (alpha * _fg[i] + ((1 - alpha) * _bg[i]))

        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blend(1), blend(2), blend(3))
end

---Darken a color
---@param hex string
---@param amount number
---@param bg string
---@return string
M.darken = function (hex, amount, bg)
    return M.blend(hex, bg, math.abs(amount))
end

return M
