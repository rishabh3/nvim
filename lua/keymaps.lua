local utils = require("utils")
local map = utils.map

-- Set leader key
map("n", "<Space>", "<NOP>", {noremap = true})
vim.g.mapleader = ","

map("n", "<leader>h", ":set hlsearch!<CR>", {noremap = true})
map("n", "<leader>n", ":set nu!<CR>", {noremap = true})

-- Jump to file from text
map("n", "gf", ":vert winc f<CR>", {noremap = true})
-- copies filepath to clipboard by pressing yf
map("n", "yf", ":let @+=expand('%:p')<CR>", {noremap = true})
-- copies pwd to clipboard command yd
map("n", "yd", ":let @+=expand('%:p:h')<CR>", {noremap = true})
-- nerd tree toggle
map("n", "<leader>t", ":NERDTreeToggleVCS<CR>", {noremap = true})
map("n", "<leader>tf", ":NERDTreeFind %<CR>", {noremap = true})

-- window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- tab indentation
map("v", "<", "<gv", {noremap = true})
map("v", ">", ">gv", {noremap = true})

-- Tab switch buffer
map("n", "<leader>bn", ":bnext<CR>", {noremap = true})
map("n", "<leader>bp", ":bprevious<CR>", {noremap = true})

-- Buffer delete
map("n", "<leader>-", ":bdelete<CR>", {noremap = true})

-- Move selceted block of code
map("x", "<A-k>", ":move '<-2<CR>gv-gv'", {noremap = true})
map("x", "<A-j>", ":move '>+1<CR>gv-gv'", {noremap = true})

-- Split windows
map("n", "<leader>s", ":sp<CR>", {noremap = true})
map("n", "<leader>v", ":vsp<CR>", {noremap = true})

-- Coc keymaps
-- Show all diagnostics
--[[ map('n', '<leader>a', ':<C-u>CocList diagnostics<CR>', { noremap = true })
-- Manage extensions
map('n', '<leader>q', ':<C-u>CocList extensions<CR>', { noremap = true })
-- Show commands
map('n', '<leader>c', ':<C-u>CocList commands<CR>', { noremap = true })
-- Find symbol of current document
map('n', '<leader>o', ':<C-u>CocList outline<CR>', { noremap = true })
-- Search workspace symbol
map('n', '<leader>s', ':<C-u>CocList -I symbols<CR>', { noremap = true })
-- Do default action for next item.
map('n', '<leader>j', ':<C-u>CocNext<CR>', { noremap = true })
-- Do default action for previous item
map('n', '<leader>k', ':<C-u>CocNext<CR>', { noremap = true })
-- Resume latest coc list
map('n', '<leader>p', ':<C-u>CocListResume<CR>', { noremap = true }) ]]
-- Map <C-p> to open project picker
map(
    "n",
    "<C-p>",
    ":lua require'telescope'.extensions.project.project{ display_type='full' }<CR>",
    {
        noremap = true,
        silent = true
    }
)

map("n", "<C-f>", ":Format<CR>", {noremap = true, silent = true})
