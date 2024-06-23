local sysname = vim.uv.os_uname().sysname
local is_win  = sysname == "Windows_NT"

return {
    is_linux = sysname == "Linux",
    is_mac   = sysname == "Darwin",
    is_win   = is_win,
    sep      = is_win and "\\" or "/",
    opt      = {
        textwidth   = 180,
        indentation = 4,
    },
    dir      = {
        home = os.getenv(is_win and "USERPROFILE" or "HOME"),
        nvim = {
            config = vim.fn.stdpath("config"),
            cache  = vim.fn.stdpath("cache"),
            data   = vim.fn.stdpath("data"),
        },
    },
}
