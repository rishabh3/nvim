require "nvim-treesitter.configs".setup {
    highlight = {
        enable = true,
        custom_captures = {},
        additional_vim_regex_highlighting = false
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },
    indent = {
        enable = true
    },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	}
}

vim.g.foldmethod='expr'
vim.g.foldexpr='nvim_treesitter#foldexpr()'
