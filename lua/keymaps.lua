local map = vim.api.nvim_set_keymap
local cmd = vim.cmd -- vim command
local g = vim.g -- global variable

local option = {noremap = true}
local option_silent = {noremap = true, silent = true}

-- Set leader key
map("n", "<Space>", "<NOP>", option)
g.mapleader = ","

map("n", "<leader>h", ":set hlsearch!<CR>", option)
map("n", "<leader>n", ":set nu!<CR>", option)

-- Jump to file from text
map("n", "gf", ":vert winc f<CR>", option)
-- copies filepath to clipboard by pressing yf
map("n", "yf", ":let @+=expand('%:p')<CR>", option)
-- copies pwd to clipboard command yd
map("n", "yd", ":let @+=expand('%:p:h')<CR>", option)
-- window movement
map("n", "<C-h>", "<C-w>h", option)
map("n", "<C-j>", "<C-w>j", option)
map("n", "<C-k>", "<C-w>k", option)
map("n", "<C-l>", "<C-w>l", option)

-- tab indentation
map("v", "<", "<gv", option)
map("v", ">", ">gv", option)

-- split
map("n", "<leader>vsp", ":vsplit<CR>", option)
map("n", "<leader>hsp", ":split<CR>", option)

-- Tab switch buffer
map("n", "<leader>bn", ":bnext<CR>", option)
map("n", "<leader>bp", ":bprevious<CR>", option)

-- Buffer delete
map("n", "<leader>-", ":bdelete<CR>", option)

-- Move selceted block of code
map("x", "<A-k>", ":move '<-2<CR>gv-gv'", option)
map("x", "<A-j>", ":move '>+1<CR>gv-gv'", option)