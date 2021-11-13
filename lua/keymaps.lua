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

map("n", "<leader>qf", ":TroubleToggle<CR>", {noremap = true, silent = true})
map("n", "<leader>qfr", ":TroubleRefresh<CR>", {noremap = true, silent = true})

map("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<cr>", {noremap = true, silent = true})

map("n", "<leader>fg", ":lua require'telescope.builtin'.live_grep()<cr>", {noremap = true, silent = true})

map("n", "<leader>fk", ":lua require'telescope.builtin'.keymaps()<cr>", {noremap = true, silent = true})

map("n", "<leader>fr", ":lua require'telescope.builtin'.lsp_references()<cr>", {noremap = true, silent = true})

map("n", "<leader>fd", ":lua require'telescope.builtin'.lsp_definitions()<cr>", {noremap = true, silent = true})

map("n", "<leader>ftd", ":lua require'telescope.builtin'.lsp_type_definitions()<cr>", {noremap = true, silent = true})

map("n", "<leader>fi", ":lua require'telescope.builtin'.lsp_implementations()<cr>", {noremap = true, silent = true})

map("n", "<leader>fb", ":Telescope buffers<cr>", {noremap = true, silent = true})
map("n", "<leader>fh", ":Telescope help_tags<cr>", {noremap = true, silent = true})
map("n", "<leader>fgs", ":Telescope git_status<cr>", {noremap = true, silent = true})
map("n", "<leader>fgc", ":Telescope git_commits<cr>", {noremap = true, silent = true})
map("n", "<leader>fgb", ":Telescope git_branches<cr>", {noremap = true, silent = true})
map("n", "<leader>fm", ":Telescope marks<cr>", {noremap = true, silent = true})
map("n", "<leader>fj", ":Telescope jumplist<cr>", {noremap = true, silent = true})
map("n", "<leader>fc", ":Telescope lsp_code_actions<cr>", {noremap = true, silent = true})
map("n", "<leader>fcs", ":Telescope colorscheme<cr>", {noremap = true, silent = true})
map("n", "<leader>ft", ":Telescope file_browser <cr>", {noremap = true, silent = true})
