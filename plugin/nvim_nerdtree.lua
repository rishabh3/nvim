local map = vim.api.nvim_set_keymap
local g = vim.g -- global variable

local option = {noremap = true}
local option_silent = {noremap = true, silent = true}

-- Nerd tree toggle
map("n", "<leader>e", ":NvimTreeToggle<CR>", option)
map("n", "<leader>tr", ":NvimTreeRefresh<CR>", option)
map("n", "<leader>tf", ":NvimTreeFindFile<CR>", option)

-- lua
g.nvim_tree_respect_buf_cwd = 1

require("nvim-tree").setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})

