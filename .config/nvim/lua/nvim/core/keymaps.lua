local keymap = vim.keymap.set

keymap("n", "<A-k>", "<CMD>resize -2<CR>", { silent = true })
keymap("n", "<A-j>", "<CMD>resize +2<CR>", { silent = true })
keymap("n", "<A-h>", "<CMD>vertical resize -2<CR>", { silent = true })
keymap("n", "<A-l>", "<CMD>vertical resize +2<CR>", { silent = true })

keymap("n", "<", "<<", { noremap = true })
keymap("n", ">", ">>", { noremap = true })
keymap("v", "<", "<gv", { noremap = true })
keymap("v", ">", ">gv", { noremap = true })

keymap("n", "yae", "ggyG", { noremap = true })
keymap("n", "cae", "ggcG", { noremap = true })
keymap("n", "dae", "ggdG", { noremap = true })
keymap("n", "vae", "ggVG", { noremap = true })

keymap("t", "<C-\\><Esc>", "<C-\\><C-n>", { noremap = true })
