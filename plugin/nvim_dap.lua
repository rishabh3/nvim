local dap = require("dap")

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
