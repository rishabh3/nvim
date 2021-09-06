local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
-- Highlight on yank
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)
utils.opt('o', 'hidden', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 8 )
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('o', 'clipboard','unnamedplus')
utils.opt('o', 'encoding', 'utf-8')
utils.opt('o', 'cmdheight', 2)
utils.opt('w', 'wrap', true)
utils.opt('o', 'whichwrap', '<,>,[,],h,l')
utils.opt('o', 'pumheight', 10)
utils.opt('o', 'fileencoding', 'utf-8')
utils.opt('o', 'ruler', true)
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'conceallevel', 0)
utils.opt('o', 'smarttab', true)
utils.opt('o', 'autoindent', true)
utils.opt('o', 'laststatus', 2)
utils.opt('w', 'cursorline', true)
utils.opt('o', 'background', 'dark')
utils.opt('o', 'showtabline', indent)
utils.opt('o', 'showmode', false)
utils.opt('o', 'backup', false)
utils.opt('o', 'writebackup', false)
utils.opt('o', 'shortmess', 'filnxtToOFc')
utils.opt('w', 'signcolumn', 'yes')
utils.opt('o', 'updatetime', 300)
utils.opt('o', 'incsearch', true)
utils.opt('w', 'cc', '100')
