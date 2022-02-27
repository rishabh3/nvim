local map = vim.api.nvim_set_keymap

local option = {noremap = true}

map("n", "<C-p>", ":Telescope projects<CR>", option)
require("project_nvim").setup {
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".root" },
	show_hidden = true
}
