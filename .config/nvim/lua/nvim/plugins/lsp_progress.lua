return {
    "linrongbin16/lsp-progress.nvim",
    config = function ()
        local lsp_progress = require("lsp-progress")

        -- Setup
        lsp_progress.setup({
            spinner          = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
            spin_update_time = 125,
            decay            = 2000,
            event            = "LspProgressUpdated",
            series_format    = function (title, message, percentage)
                local messages = {}

                if title and #title > 0 then
                    table.insert(messages, title)
                end

                if message and #message > 0 then
                    table.insert(messages, message)
                end

                if percentage and #messages > 0 then
                    table.insert(messages, ("(%.0f%%)"):format(percentage))
                end

                return table.concat(messages, " ")
            end,
            client_format    = function (client_name, spinner, series_messages)
                if #series_messages == 0 then
                    return nil
                end

                return ("[%s] %s %s"):format(client_name, spinner, series_messages[1])
            end,
            format           = function (client_messages)
                return table.concat(client_messages, " ")
            end,
        })

        -- Set autocmds
        vim.cmd([[
          augroup LspProgress
          au!
          autocmd User LspProgressUpdated setlocal statusline=%!v:lua.build_statusline()
          augroup END
        ]])
    end,
}
