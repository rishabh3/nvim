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

-- Markdown preview shortcut
map("n", "<leader>md", ":Glow<cr>", {noremap = true, silent = true})

-- Dap
map("n", "<leader>dh", ':lua require"dap".toggle_breakpoint()<CR>', {noremap = true, silent = true})
map(
    "n",
    "<leader>dH",
    ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    {noremap = true, silent = true}
)
map("n", "<leader>so", ':lua require"dap".step_out()<CR>', {noremap = true, silent = true})
map("n", "<leader>si", ':lua require"dap".step_into()<CR>', {noremap = true, silent = true})
map("n", "<leader>sv", ':lua require"dap".step_over()<CR>', {noremap = true, silent = true})
map("n", "<leader>sc", ':lua require"dap".continue()<CR>', {noremap = true, silent = true})
map("n", "<leader>dk", ':lua require"dap".up()<CR>', {noremap = true, silent = true})
map("n", "<leader>dj", ':lua require"dap".down()<CR>', {noremap = true, silent = true})
map("n", "<leader>dc", ':lua require"dap".terminate()<CR>', {noremap = true, silent = true})
map("n", "<leader>dr", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l', {noremap = true, silent = true})
map("n", "<leader>di", ':lua require"dap.ui.variables".hover()<CR>', {noremap = true, silent = true})
map("n", "<leader>di", ':lua require"dap.ui.variables".visual_hover()<CR>', {noremap = true, silent = true})
map("n", "<leader>d?", ':lua require"dap.ui.variables".scopes()<CR>', {noremap = true, silent = true})
map("n", "<leader>de", ':lua require"dap".set_exception_breakpoints({"all"})<CR>', {noremap = true, silent = true})
map("n", "<leader>da", ':lua require"debugHelper".attach()<CR>', {noremap = true, silent = true})
map("n", "<leader>dA", ':lua require"debugHelper".attachToRemote()<CR>', {noremap = true, silent = true})
map("n", "<leader>du", ':lua require"dap.ui.widgets".hover()<CR>', {noremap = true, silent = true})
map(
    "n",
    "<leader>d?",
    ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>',
    {noremap = true, silent = true}
)

map("n", "<leader>tn", ":lua require'jdtls'.test_nearest_method()<CR>", {noremap = true, silent = true})
map("n", "<leader>tc", ":lua require'jdtls'.test_class()<CR>", {noremap = true, silent = true})

map("n", "<leader>ds", ":Telescope dap frames<CR>", {noremap = true, silent = true})
map("n", "<leader>db", ":Telescope dap list_breakpoints<CR>", {noremap = true, silent = true})

map("n", "<leader>O", ":lua require('dapui').open()<CR>", {noremap = true, silent = true})
map("n", "<leader>C", ":lua require('dapui').close()<CR>", {noremap = true, silent = true})
map("n", "<leader>T", ":lua require('dapui').toggle()<CR>", {noremap = true, silent = true})

map("v", "<leader>F", ":lua vim.lsp.buf.range_formatting()<CR>", {noremap = true, silent = true})

map("n", "<leader>syc", ":SymClassSearch<CR>", {noremap = true, silent = true})
map("n", "<leader>sym", ":SymMethodSearch<CR>", {noremap = true, silent = true})
map("n", "<leader>syf", ":SymFieldSearch<CR>", {noremap = true, silent = true})
