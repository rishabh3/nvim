-- init.lua contains all of the initialization plugins for vim note;
-- This has to be sourced second since dein needs to run its scripts first.
-- This contains misc startup settings for vim
local g = vim.g     -- global variable
local opt = vim.opt -- set options
local cmd = vim.cmd -- vim command
local home = os.getenv("HOME")  -- get home

-- set notification function
vim.notify = require('notify')

-- set system python3
g.python3_host_prog = '~/.virtualenvs/py3venv/bin/python'
g.floaterm_width = 0.8
g.floaterm_height = 0.8

cmd('syntax on')
cmd('filetype indent plugin on')

-- global options
opt.showcmd       = true      -- show command info at bottom
opt.showmatch     = true      -- brefiely highlight matching grouping symbols
opt.laststatus    = 2         -- 2: show statusline in all windows
opt.backspace     = 'indent,eol,start'       -- allow unrestricted backspacing in insert mode
opt.ruler         = true      -- show current line/col number
opt.scrolloff     = 10        -- number of lines from edge until screen scroll
opt.mouse         = 'a'       -- enable all mouse modes
opt.mousemodel    = 'popup'   -- right click pops up window
opt.grepprg       = 'rg\\ --vimgrep'         -- use rg for vimgrep
opt.hidden        = true      -- hide unloaded buffers instead of abandoning
opt.splitbelow    = true      -- make hsplit below current window
opt.splitright    = true      -- make vsplit to right of current window
opt.inccommand    = 'nosplit' -- show affects of commands incrimentally
opt.incsearch     = true      -- incremental search
opt.visualbell    = true      -- show visual bell instead of beeping
--opt.virtualedit   = opt.virtualedit + 'block' -- allow virual editing in visual block
-- window options
opt.spell        = false     -- don't check spelling
opt.wrap         = true     -- don't wrap text lines
opt.number       = true      -- show line number on left
opt.relativenumber = true    -- show relative number
opt.cursorline   = true      -- show cursorline
-- buffer options
opt.autoindent   = true      -- maintain indent of current line
opt.tabstop      = 4         -- number of spaces in a tab
opt.expandtab    = false     -- use spaces instead of tab characters
opt.softtabstop  = 4         -- make spaces feel like tabs backspacing
opt.synmaxcol    = 200       -- don't highlight long lines
opt.smartindent  = true      -- smart indent for C like programs
opt.smartcase    = true      -- smart case while searching
opt.smarttab     = true      -- smart tab to fill tabstop spaces or delete tabstop spaces

-- set options
opt.shiftwidth  = 4         -- read help to set up later
g.browsedir     = 'buffer'  -- put up directory requestor
opt.hlsearch    = false     -- don't highlight for searching
opt.ignorecase  = true      -- ignore case for pattern matching
opt.wildmode    = 'list:longest' -- replacing wild chars
opt.clipboard   = opt.clipboard + 'unnamedplus' -- copy with system clipboard
opt.modeline    = false     -- the modeline is a well-known security risk
opt.encoding    = 'utf-8'   -- encoding for the file
opt.cmdheight   = 2         -- cmd height
opt.showtabline = 4         -- show tabline
opt.colorcolumn = "100"     -- show wrap line

-- set colorscheme
opt.termguicolors = true      -- enable 24bit colors in TUI, uses guibg/guifg
opt.background    = 'dark'    -- set background dark/light
-- cmd('colorscheme gruvbox')      -- use everforest colorscheme; plays nice with redshift
--cmd('highlight Normal guibg=grey') -- keep transparent guibg
-- highlight 81st column darkred on lines that run long
cmd([[autocmd BufEnter,FocusGained,BufWinEnter,WinEnter * match ColorColumn "\%81v."]])


opt.showbreak        = '↪'            -- str to put at begining of wrapped lines
opt.list            =  false-- show whitesoace chars
-- opt.listchars      = {
-- --  nbsp             = '␣',
-- --  extends          = '❯',
-- --  precedes         = '❮',
-- --  tab              = '',
--  eol              = '¬'
-- }

-- opt.fillchars      = {
--  diff             = '∙',           -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
--  eob              = ' ',           -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
--  fold             = '·',           -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
--  vert             = '┃',           -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
-- }
-- file encoding
opt.fileencoding = 'utf-8'  -- file content encoding for current buffer
opt.fileencodings = 'utf-8'  -- list of encoding considered when starting a file
--opt.fileformats   = {'unix', 'dos', 'mac'} -- gives eol formats
--opt.formatpgr     = 'par'    -- name of external program used to format lines

-- backups
opt.backupskip    = '/tmp/*,/private/tmp/*",*.gpg' -- don't backup filename with these patterns
opt.backupdir     = home .. '/.local/nvim/tmp/.backup/' -- where to store backup files
opt.undodir       = home .. '/.local/nvim/tmp/.undo/' -- where to store undo files
opt.directory     = home .. '/.local/nvim/tmp/.swp/' -- where to store swap files
opt.backup        = true  -- make backup before overwriting files
opt.swapfile      = false -- its 2021, just do backups

-- make dirs for backup
cmd([[
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
]])

-- fold expr
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"