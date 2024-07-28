return {
    "stevearc/conform.nvim",
    config = function ()
        local conform = require("conform")

        -- Setup
        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                vue = { "prettier" },
            },
        })
    end,
}
