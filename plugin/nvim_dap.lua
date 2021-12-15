local dap = require("dap")

dap.defaults.fallback.terminal_win_cmd = '80vsplit new'

vim.fn.sign_define('DapBreakpoint', {text='✋', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🚫', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})
