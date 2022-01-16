local map = vim.api.nvim_set_keymap
local option_silent = {noremap = true, silent = true}

map("n", "<leader>qf", ":TroubleToggle<CR>", option_silent)
map("n", "<leader>qfr", ":TroubleRefresh<CR>", option_silent)

require "trouble".setup {
    height = 20,
    action_keys = {
        open_split = {"<leader>s"},
        open_vsplit = {"<leader>v"}
    }
}