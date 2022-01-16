local map = vim.api.nvim_set_keymap
local g = vim.g -- global variable

local option = {noremap = true}
local option_silent = {noremap = true, silent = true}

-- Nerd tree toggle
map("n", "<leader>e", ":NvimTreeToggle<CR>", option)
map("n", "<leader>tr", ":NvimTreeRefresh<CR>", option)
map("n", "<leader>tf", ":NvimTreeFindFile<CR>", option)

