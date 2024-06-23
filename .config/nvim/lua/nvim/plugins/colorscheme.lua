return {
    {
        "dgox16/oldworld.nvim",
        lazy     = false,
        priority = 1000,
        config   = function ()
            local oldworld = require("oldworld")
            local util     = require("nvim.lib.util")

            -- Setup
            oldworld.setup({
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = {},
                    identifiers = {},
                    functions = {},
                    variables = {},
                    booleans = { bold = true },
                },
                integrations = {
                    alpha = true,
                    cmp = true,
                    flash = true,
                    gitsigns = true,
                    hop = false,
                    indent_blankline = true,
                    lazy = true,
                    lsp = true,
                    markdown = true,
                    mason = true,
                    navic = false,
                    neo_tree = false,
                    noice = true,
                    notify = true,
                    rainbow_delimiters = true,
                    telescope = false,
                    treesitter = true,
                },
            })

            vim.cmd.colorscheme("oldworld")

            -- Update highlights
            local groups = {
                NormalNC                   = { link = "Normal" },
                Pmenu                      = { fg = "#c9c7cd", bg = "#18181a" },
                PmenuSbar                  = { fg = "#c9c7cd", bg = "#18181a" },
                TabLineFill                = { bg = "#1b1b1c" },
                DiagnosticVirtualTextError = { fg = "#ea83a5", bg = util.darken("#ea83a5", 0.095, "#161617"), italic = true },
                DiagnosticVirtualTextWarn  = { fg = "#e6b99d", bg = util.darken("#e6b99d", 0.095, "#161617"), italic = true },
                DiagnosticVirtualTextInfo  = { fg = "#aca1cf", bg = util.darken("#aca1cf", 0.095, "#161617"), italic = true },
                DiagnosticVirtualTextHint  = { fg = "#85b5ba", bg = util.darken("#85b5ba", 0.095, "#161617"), italic = true },
            }

            for group, opts in pairs(groups) do
                vim.api.nvim_set_hl(0, group, opts)
            end
        end,
    },
    {
        "catppuccin/nvim",
        name     = "catppuccin",
        lazy     = false,
        priority = 1000,
        config   = function ()
            require("catppuccin").setup({
                flavour                = "mocha",
                transparent_background = false,
                show_end_of_buffer     = true,
                term_colors            = true,
                dim_inactive           = {
                    enabled = false,
                },
                no_italic              = false,
                no_bold                = false,
                no_underline           = true,
                styles                 = {
                    comments     = { "italic" },
                    conditionals = {},
                    loops        = {},
                    functions    = { "italic" },
                    keywords     = {},
                    strings      = {},
                    variables    = {},
                    numbers      = { "bold" },
                    booleans     = { "bold" },
                    properties   = {},
                    types        = {},
                    operators    = {},
                    -- miscs = {},
                },
                color_overrides        = {
                    mocha = {
                        rosewater = "#efc9c2",
                        flamingo  = "#ebb2b2",
                        pink      = "#f2a7de",
                        mauve     = "#b889f4",
                        red       = "#ea7183",
                        maroon    = "#ea838c",
                        peach     = "#f39967",
                        yellow    = "#eaca89",
                        green     = "#96d382",
                        teal      = "#78cec1",
                        sky       = "#91d7e3",
                        sapphire  = "#68bae0",
                        blue      = "#739df2",
                        lavender  = "#a0a8f6",
                        text      = "#b5c1f1",
                        subtext1  = "#a6b0d8",
                        subtext0  = "#959ec2",
                        overlay2  = "#848cad",
                        overlay1  = "#717997",
                        overlay0  = "#63677f",
                        surface2  = "#505469",
                        surface1  = "#3e4255",
                        surface0  = "#2c2f40",
                        base      = "#1a1c2a",
                        mantle    = "#141620",
                        crust     = "#0e0f16",
                    },
                },
                highlight_overrides    = {
                    mocha = function (mocha)
                        return {
                            TabLine               = { bg = mocha.mantle, fg = mocha.text },
                            TabLineFill           = { bg = mocha.mantle },
                            TabLineSel            = { bg = mocha.mantle, fg = mocha.text, bold = true },
                            Pmenu                 = { link = "NormalFloat" },
                            PmenuSbar             = { bg = mocha.mantle },
                            -- WinSeparator = { bg = mocha.mantle },
                            CmpItemAbbr           = { fg = mocha.text },
                            CmpItemAbbrMatch      = { link = "CmpItemAbbr" },
                            CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbr" },
                        }
                    end,
                },
                default_integrations   = true,
            })

            -- vim.cmd.colorscheme("catppuccin")
        end,
    },
}
