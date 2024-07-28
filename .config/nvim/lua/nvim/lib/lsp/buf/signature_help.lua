return function ()
    local text   = vim.fn.getline(".")
    local col    = vim.fn.col(".")

    local params = vim.lsp.util.make_position_params()

    for i = col, #text do
        local ch = text:sub(i, i)

        if ch == "(" then
            params.position.character = i
            break
        elseif ch == " " then
            break
        end
    end

    vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function (_, result, ctx, config)
        config = config or {}

        config.focus_id = ctx.method

        if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
            -- Ignore result since buffer changed. This happens for slow language servers.
            return
        end

        if not (result and result.signatures and result.signatures[1]) then
            if config.silent ~= true then
                print("No signature help available")
            end
            return
        end

        local client    = assert(vim.lsp.get_client_by_id(ctx.client_id))
        local triggers  = vim.tbl_get(client.server_capabilities, "signatureHelpProvider", "triggerCharacters")
        local ft        = vim.bo[ctx.bufnr].filetype
        local lines, hl = vim.lsp.util.convert_signature_help_to_markdown_lines(result, ft, triggers)

        if not lines or vim.tbl_isempty(lines) then
            if config.silent ~= true then
                print("No signature help available")
            end
            return
        end

        local fbuf, fwin = vim.lsp.util.open_floating_preview(lines, "markdown", config)

        if hl then
            -- Highlight the second line if the signature is wrapped in a Markdown code block.
            local line = vim.startswith(lines[1], "```") and 1 or 0
            vim.api.nvim_buf_add_highlight(fbuf, -1, "LspSignatureActiveParameter", line, unpack(hl))
        end

        return fbuf, fwin
    end)
end
