-- Plugins for Git and its configuration
local map = vim.api.nvim_set_keymap

local option_silent = {noremap = true, silent = true}

map("n", "<Leader>gb", ":Git blame<CR>", option_silent)
map("n", "<Leader>ga", ":Git add %:p<CR>", option_silent)
map("n", "<Leader>gs", ":Git<CR>", option_silent)
map("n", "<Leader>gc", ":Git commit -v -q<CR>", option_silent)
map("n", "<Leader>gt", ":Git commit -v -q %:p<CR>", option_silent)
map("n", "<Leader>gd", ":Gdiffsplit<CR>", option_silent)
map("n", "<Leader>ge", ":Gedit<CR>", option_silent)
map("n", "<Leader>gr", ":Gread<CR>", option_silent)
map("n", "<Leader>gw", ":Gwrite<CR>", option_silent)
map("n", "<Leader>gl", ":silent! Gclog<CR>:bot copen", option_silent)
map("n", "<Leader>gp", ":Ggrep<CR>", option_silent)
map("n", "<Leader>gm", ":GMove<CR>", option_silent)
map("n", "<Leader>gbr", ":Git branch<CR>", option_silent)
map("n", "<Leader>gbr", ":Git branch<CR>", option_silent)
map("n", "<Leader>gco", ":Git checkout<CR>", option_silent)
map("n", "<Leader>gf", ":Git fetch<CR>", option_silent)
map("n", "<Leader>gps", ":Git push -u origin HEAD<CR>", option_silent)
map("n", "<Leader>gpl", ":Git pull<CR>", option_silent)

require'gitsigns'.setup {
    word_diff = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000
    }
}