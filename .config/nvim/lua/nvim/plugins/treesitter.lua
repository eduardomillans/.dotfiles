return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/playground" },
    build = ":TSUpdate",
    config = function ()
        local treesitter = require("nvim-treesitter.configs")

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
