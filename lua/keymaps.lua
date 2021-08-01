local utils = require('utils')
local map = utils.map

-- Set leader key
map('n', '<Space>', '<NOP>', { noremap = true })
vim.g.mapleader = ' '

map('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true })
map('n', '<Leader>n', ':set nu!<CR>', { noremap = true })

-- nerd tree toggle
map('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true })

-- window movement
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- tab indentation
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })


-- Tab switch buffer
map('n', '<TAB>', ':bnext<CR>', { noremap = true })
map('n', '<S-TAB>', ':bprevious<CR>', { noremap = true })


-- Buffer delete
map('n', '<Leader>-', ':bdelete<CR>', { noremap = true })

-- Move selceted block of code
map('x', 'K', ':move \'<-2<CR>gv-gv\'', { noremap = true })
map('x', 'J', ':move \'<+1<CR>gv-gv\'', { noremap = true })


-- Split windows
map('n', '<Leader>s', ':sp<CR>', { noremap = true })
map('n', '<Leader>v', ':vsp<CR>', { noremap = true })


-- Coc keymaps
-- Show all diagnostics
map('n', '<Leader>a', ':<C-u>CocList diagnostics<CR>', { noremap = true })
-- Manage extensions
map('n', '<Leader>q', ':<C-u>CocList extensions<CR>', { noremap = true })
-- Show commands
map('n', '<Leader>c', ':<C-u>CocList commands<CR>', { noremap = true })
-- Find symbol of current document
map('n', '<Leader>o', ':<C-u>CocList outline<CR>', { noremap = true })
-- Search workspace symbol
map('n', '<Leader>s', ':<C-u>CocList -I symbols<CR>', { noremap = true })
-- Do default action for next item.
map('n', '<Leader>j', ':<C-u>CocNext<CR>', { noremap = true })
-- Do default action for previous item
map('n', '<Leader>k', ':<C-u>CocNext<CR>', { noremap = true })
-- Resume latest coc list
map('n', '<Leader>p', ':<C-u>CocListResume<CR>', { noremap = true })


