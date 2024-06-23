local global       = require("nvim.core.global")
local util         = require("nvim.lib.util")
local on_attach    = require("nvim.lsp.on_attach")
local capabilities = require("nvim.lsp.capabilities")

return {
    bashls        = {
        on_attach    = on_attach({ formatting = false }),
        capabilities = capabilities,
        filetypes    = { "sh", "zsh" },
        settings     = {
            bashIde = {
                globPattern = "*@(.sh|.inc|.bash|.zsh|.command)",
            },
        },
    },
    cssls         = {
        on_attach    = on_attach({ formatting = false }),
        capabilities = capabilities,
    },
    eslint        = {
        on_attach    = on_attach(),
        capabilities = capabilities,
    },
    html          = {
        on_attach    = on_attach({ formatting = false }),
        capabilities = capabilities,
    },
    intelephense  = {
        on_attach    = on_attach(),
        capabilities = capabilities,
        init_options = {
            storagePath       = util.path(global.dir.nvim.cache, "intelephense"),
            globalStoragePath = util.path(global.dir.nvim.cache, "intelephense"),
        },
        settings     = {
            intelephense = {
                format = {
                    braces = "k&r",
                },
            },
        },
    },
    jsonls        = {
        on_attach    = on_attach({ formatting = false }),
        capabilities = capabilities,
    },
    lua_ls        = {
        on_attach    = on_attach(),
        capabilities = capabilities,
        on_init      = function (client)
            local path = client.workspace_folders[1].name

            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    version = "LuaJIT"
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            })
        end,
        settings     = {
            Lua = {},
        },
    },
    rust_analyzer = {
        on_attach    = on_attach(),
        capabilities = capabilities,
    },
    tailwindcss   = {
        on_attach    = on_attach({ formatting = false }),
        capabilities = capabilities,
    },
    vtsls = {
        on_attach    = on_attach({ formatting = false }),
        capabilities = capabilities,
        settings     = {
            typescript = {
                preferences = {
                    importModuleSpecifier = "non-relative",
                },
            },
        },
    },
    vimls = {
        on_attach    = on_attach(),
        capabilities = capabilities,
    },
}
