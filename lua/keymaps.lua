map = function (mode, newmap, oldmap, props) vim.api.nvim_set_keymap(mode, newmap, oldmap, props) end

-- Set leader key
map('n', '<Space>', '<NOP>', { noremap = true, silent = true })
vim.g.mapleader = ' '

map('n', '<Leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })
map('n', '<Leader>n', ':set nu!<CR>', { noremap = true, silent = true })

-- nerd tree toggle
map('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- window movement
map('n', '<C-h>', '<C-w>h', { silent = true })
map('n', '<C-j>', '<C-w>j', { silent = true })
map('n', '<C-k>', '<C-w>k', { silent = true })
map('n', '<C-l>', '<C-w>l', { silent = true })

-- tab indentation
map('v', '<', '<gv', { noremap = true, silent = true })
map('v', '>', '>gv', { noremap = true, silent = true })


-- Tab switch buffer
map('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true })
map('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent = true })


-- Buffer delete
map('n', '<Leader>-', ':bdelete<CR>', { noremap = true, silent = true })

-- Move selceted block of code
map('x', 'K', ':move \'<-2<CR>gv-gv\'', { noremap = true, silent = true })
map('x', 'J', ':move \'<+1<CR>gv-gv\'', { noremap = true, silent = true })
