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

-- Terminal
map("n","<leader>tn", ":lua require('term').toggle()<CR>", option_silent)
map("n", "<leader>te", ":lua require('term').run()<CR>", option_silent)
map("n", "<leader>ts", ":lua require('term').sendLine(vim.fn.getline('.'))<CR>", option_silent)
map("n", "<leader>ts", "<ESC>:lua require('term').sendSelection()<CR>", option_silent)

-- Symbol
map("n", "<leader>ol", ":SymbolsOutline<CR>", option)

-- Dap
map("n", "<leader>db", ':lua require"dap".toggle_breakpoint()<CR>', option_silent)
map("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", option_silent)
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

map("n", "<leader>ds", ":Telescope dap frames<CR>", option_silent)
map("n", "<leader>dbs", ":Telescope dap list_breakpoints<CR>", option_silent)

map("n", "<leader>O", ":lua require('dapui').open()<CR>", option_silent)
map("n", "<leader>C", ":lua require('dapui').close()<CR>", option_silent)
map("n", "<leader>T", ":lua require('dapui').toggle()<CR>", option_silent)
map("n", "<leader>dcfg", ":Telescope dap configurations<CR>", option_silent)

