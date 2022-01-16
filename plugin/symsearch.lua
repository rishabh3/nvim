local symsearch = require("symsearch")
local map = vim.api.nvim_set_keymap

local option_silent = {noremap = true, silent = true}

map("n", "<leader>syc", ":SymClassSearch<CR>", option_silent)
map("n", "<leader>sym", ":SymMethodSearch<CR>", option_silent)
map("n", "<leader>syf", ":SymFieldSearch<CR>", option_silent)

symsearch.setup()