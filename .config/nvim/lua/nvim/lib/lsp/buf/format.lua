local blacklist = { "cssls", "html", "jsonls", "volar", "vtsls" }

return function ()
    local is_installed, conform = pcall(require, "conform")

    if is_installed then
        if not vim.tbl_isempty(conform.list_formatters()) then
            conform.format()
            return
        end
    end

    vim.lsp.buf.format({
        filter = function (client)
            return not vim.tbl_contains(blacklist, client.name)
        end,
    })
end
