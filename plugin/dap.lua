local dap = require("dap")
local map = vim.api.nvim_set_keymap

local option_silent = {noremap = true, silent=true}

dap.defaults.fallback.terminal_win_cmd = '60vsplit new'

vim.fn.sign_define('DapBreakpoint', {text='✋', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})

local home = os.getenv("HOME")


-- Debug Configuration for Python
dap.adapters.python = {
	type = 'executable';
	command = home .. "/.virutalenvs/py3venv/bin/python"
}

dap.configurations.python = {
	{
		type = 'python';
		request = 'launch';
		name = 'Launch file';
		
		program = "${file}";
		pythonPath = function ()
			if vim.fn.executable(home .. "/.virtualenvs/py3venv/bin/python") == 1 then
				return home .. "/.virtualenvs/py3venv/bin/python"
			else
				return '/usr/bin/python3'
			end
		end
	}
}

local dap_install = require("dap-install")

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

-- Keymaps for dap
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
