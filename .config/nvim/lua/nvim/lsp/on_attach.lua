return function (args)
    local formatting = args and args.formatting or true
    local inlay_hint = args and args.inlay_hint or true

    return function (client)
        -- Formattting
        client.server_capabilities.document_formatting       = formatting
        client.server_capabilities.document_range_formatting = formatting

        -- Inlay hints
        if client.server_capabilities.inlayHintProvider then
            if inlay_hint then
                vim.lsp.inlay_hint.enable();
            end
        end
    end
end
