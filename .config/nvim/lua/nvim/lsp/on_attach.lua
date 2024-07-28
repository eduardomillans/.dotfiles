return function (args)
    local formatting = args and args.formatting or true

    return function (client)
        -- Formattting
        client.server_capabilities.document_formatting       = formatting
        client.server_capabilities.document_range_formatting = formatting
    end
end
