return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/playground" },
    build = ":TSUpdate",
    config = function ()
        local treesitter    = require("nvim-treesitter.configs")
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        -- Parsers
        local parsers       = {
            blade = {
                install_info = {
                    url = "https://github.com/EmranMR/tree-sitter-blade",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "blade",
            },
        }

        for parser, config in pairs(parsers) do
            parser_config[parser] = config
        end

        -- Setup
        treesitter.setup({
            auto_install = true,
            highlight    = {
                enable = true,
            },
            indent       = {
                enable = { "php" },
            },
        })
    end,
}
