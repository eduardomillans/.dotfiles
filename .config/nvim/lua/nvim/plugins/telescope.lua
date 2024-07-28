return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "FabianWirth/search.nvim" }
    },
    config = function ()
        local telescope = require("telescope")
        local builtin   = require("telescope.builtin")
        local actions   = require("telescope.actions")
        local search    = require("search")

        -- Keymaps
        local keymap    = vim.keymap.set

        keymap("n", "<C-f>", function () search.open({ collection = "search" }) end, { noremap = true })
        keymap("n", "<C-g>", function () search.open({ collection = "git" }) end, { noremap = true })

        -- Extensions
        local extensions = { "fzf" }

        for _, extension in ipairs(extensions) do
            telescope.load_extension(extension)
        end

        -- Helpers
        local is_git_dir = function ()
            return vim.fn.isdirectory(".git") == 1
        end

        -- Setup
        telescope.setup({
            defaults = {
                prompt_prefix        = "> ",
                selection_caret      = "> ",
                entry_prefix         = "  ",
                file_ignore_patterns = { ".git/" },
                vimgrep_arguments    = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                sorting_strategy     = "ascending",
                layout_config        = {
                    preview_width = 0.5,
                },
                mappings             = {
                    i = {
                        ["<C-\\><Esc>"] = { "<esc>", type = "command" },
                        ["<Esc>"]       = actions.close,
                        ["<C-s>"]       = actions.toggle_selection,
                    },
                    n = {
                        ["<C-s>"] = actions.toggle_selection,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        })

        search.setup({
            mappings    = {
                next = "<Tab>",
                prev = "<S-Tab>"
            },
            tabs        = {
                { "builtin", tele_func = builtin.builtin },
            },
            collections = {
                search = {
                    tabs = {
                        { "Files",   tele_func = builtin.find_files },
                        { "Buffers", tele_func = builtin.buffers },
                        { "Grep",    tele_func = builtin.live_grep },
                    },
                },
                git    = {
                    tabs = {
                        { name = "Branches", tele_func = builtin.git_branches, available = is_git_dir },
                        { name = "Commits",  tele_func = builtin.git_commits,  available = is_git_dir },
                        { name = "Status",   tele_func = builtin.git_status,   available = is_git_dir },
                        { name = "Stashes",  tele_func = builtin.git_stash,    available = is_git_dir },
                    },
                },
            },
        })
    end,
}
