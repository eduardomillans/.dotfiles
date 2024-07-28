return {
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
    {
        "ellisonleao/gruvbox.nvim",
        lazy     = false,
        priority = 1000,
        config   = function ()
            local gruvbox = require("gruvbox")

            -- Setup
            gruvbox.setup({
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,
                contrast = "hard",
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })

            vim.cmd.colorscheme("gruvbox")
        end,
    },
}
