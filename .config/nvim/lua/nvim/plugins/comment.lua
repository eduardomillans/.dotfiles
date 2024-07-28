return {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
        local comment = require("Comment")

        -- Setup
        vim.g.skip_ts_context_commentstring_module = true

        comment.setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
}
