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
-- nerd tree toggle
map("n", "<leader>e", ":NERDTreeToggleVCS<CR>", option)
map("n", "<leader>tf", ":NERDTreeFind %<CR>", option)

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

map("n", "<C-f>", ":Format<CR>", option_silent)

map("n", "<leader>qf", ":TroubleToggle<CR>", option_silent)
map("n", "<leader>qfr", ":TroubleRefresh<CR>", option_silent)

map("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<cr>", option_silent)

map("n", "<leader>fg", ":lua require'telescope.builtin'.live_grep()<cr>", option_silent)

map("n", "<leader>fk", ":lua require'telescope.builtin'.keymaps()<cr>", option_silent)

map("n", "<leader>fr", ":lua require'telescope.builtin'.lsp_references()<cr>", option_silent)

map("n", "<leader>fd", ":lua require'telescope.builtin'.lsp_definitions()<cr>", option_silent)

map("n", "<leader>ftd", ":lua require'telescope.builtin'.lsp_type_definitions()<cr>", option_silent)

map("n", "<leader>fi", ":lua require'telescope.builtin'.lsp_implementations()<cr>", option_silent)

map("n", "<leader>fb", ":Telescope buffers<cr>", option_silent)
map("n", "<leader>fh", ":Telescope help_tags<cr>", option_silent)
map("n", "<leader>fgs", ":Telescope git_status<cr>", option_silent)
map("n", "<leader>fgc", ":Telescope git_commits<cr>", option_silent)
map("n", "<leader>fgb", ":Telescope git_branches<cr>", option_silent)
map("n", "<leader>fm", ":Telescope marks<cr>", option_silent)
map("n", "<leader>fj", ":Telescope jumplist<cr>", option_silent)
map("n", "<leader>fc", ":Telescope lsp_code_actions<cr>", option_silent)
map("n", "<leader>fcs", ":Telescope colorscheme<cr>", option_silent)
map("n", "<leader>ft", ":Telescope file_browser <cr>", option_silent)

-- Markdown preview shortcut
map("n", "<leader>md", ":Glow<cr>", option_silent)

-- Dap
map("n", "<leader>dh", ':lua require"dap".toggle_breakpoint()<CR>', option_silent)
map("n", "<leader>dH", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", option_silent)
map("n", "<leader>so", ':lua require"dap".step_out()<CR>', option_silent)
map("n", "<leader>si", ':lua require"dap".step_into()<CR>', option_silent)
map("n", "<leader>sv", ':lua require"dap".step_over()<CR>', option_silent)
map("n", "<leader>sc", ':lua require"dap".continue()<CR>', option_silent)
map("n", "<leader>dk", ':lua require"dap".up()<CR>', option_silent)
map("n", "<leader>dj", ':lua require"dap".down()<CR>', option_silent)
map("n", "<leader>dc", ':lua require"dap".terminate()<CR>', option_silent)
map("n", "<leader>dr", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l', option_silent)
map("n", "<leader>di", ':lua require"dap.ui.variables".hover()<CR>', option_silent)
map("n", "<leader>di", ':lua require"dap.ui.variables".visual_hover()<CR>', option_silent)
map("n", "<leader>d?", ':lua require"dap.ui.variables".scopes()<CR>', option_silent)
map("n", "<leader>de", ':lua require"dap".set_exception_breakpoints({"all"})<CR>', option_silent)
map("n", "<leader>da", ':lua require"debugHelper".attach()<CR>', option_silent)
map("n", "<leader>dA", ':lua require"debugHelper".attachToRemote()<CR>', option_silent)
map("n", "<leader>du", ':lua require"dap.ui.widgets".hover()<CR>', option_silent)
map(
    "n",
    "<leader>d?",
    ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>',
    option_silent
)

map("n", "<leader>tn", ":lua require'jdtls'.test_nearest_method()<CR>", option_silent)
map("n", "<leader>tc", ":lua require'jdtls'.test_class()<CR>", option_silent)

map("n", "<leader>ds", ":Telescope dap frames<CR>", option_silent)
map("n", "<leader>db", ":Telescope dap list_breakpoints<CR>", option_silent)

map("n", "<leader>O", ":lua require('dapui').open()<CR>", option_silent)
map("n", "<leader>C", ":lua require('dapui').close()<CR>", option_silent)
map("n", "<leader>T", ":lua require('dapui').toggle()<CR>", option_silent)

map("v", "<leader>F", ":lua vim.lsp.buf.range_formatting()<CR>", option_silent)

map("n", "<leader>syc", ":SymClassSearch<CR>", option_silent)
map("n", "<leader>sym", ":SymMethodSearch<CR>", option_silent)
map("n", "<leader>syf", ":SymFieldSearch<CR>", option_silent)

-- Zoxide keymaps
map("n", "<leader>cd", ":lua require'telescope'.extensions.zoxide.list{}<CR>", option_silent)
map("n", "<leader>t", ":FloatermToggle<CR>", option_silent)
map("n", "<leader>cp", ":Telescope neoclip<CR>", option_silent)
