local actions = require('telescope.actions')
local prefix = "→ "
local map = vim.api.nvim_set_keymap
local option_silent = {noremap = true, silent = true}


require'telescope'.setup {
	defaults = {
        layout_config = {
          width = 0.75,
          prompt_position = "top",
          preview_cutoff = 120,
          horizontal = {mirror = false},
          vertical = {mirror = false},
        },
        find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default + actions.center
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            }
        }
    },
    pickers = {
        find_files = {
            prompt_prefix = prefix,
            selection_caret = prefix,
			hidden = true,
        },
        live_grep = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix,
        },
        keymaps = {
            theme = "cursor",
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_references = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_type_definitions = {
            theme = "cursor",
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_definitions = {
            theme = "cursor",
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_implementations = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        buffers = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        git_branches = {
            theme = 'cursor',
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        git_status = {
            prompt_prefix = prefix,
            selection_caret = prefix,
        },
        git_commits = {
            prompt_prefix = prefix,
            selection_caret = prefix,
        },
        marks = {
            prompt_prefix = prefix,
            selection_caret = prefix,
        },
        jumplist = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix,
        },
        help_tags = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        colorscheme = {
            theme = "cursor",
            prompt_prefix = prefix,
            selection_caret = prefix,
        },
        lsp_code_actions = {
            theme = "cursor",
            prompt_prefix = prefix,
            selection_caret = prefix,
        }
    }
}

 require'telescope'.load_extension('dap')
 require'telescope'.load_extension('zoxide')
 require("telescope").load_extension("notify")
 require("telescope").load_extension("neoclip")
 require("telescope").load_extension("projects")


-- Keymaps for telescope
map("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<cr>", option_silent)

map("n", "<leader>fg", ":lua require'telescope.builtin'.live_grep()<cr>", option_silent)

map("n", "<leader>fk", ":lua require'telescope.builtin'.keymaps()<cr>", option_silent)

map("n", "<leader>fr", ":lua require'telescope.builtin'.lsp_references()<cr>", option_silent)

map("n", "<leader>fd", ":lua require'telescope.builtin'.lsp_definitions()<cr>", option_silent)

map("n", "<leader>ftd", ":lua require'telescope.builtin'.lsp_type_definitions()<cr>", option_silent)

map("n", "<leader>fi", ":lua require'telescope.builtin'.lsp_implementations()<cr>", option_silent)

map("n", "<leader>fb", ":Telescope buffers<cr>", option_silent)
map("n", "<leader>fh", ":Telescope help_tags<cr>", option_silent)
map("n", "<leader>fgs", ":Telescope git_status<cr>", option_silent)
map("n", "<leader>fgc", ":Telescope git_commits<cr>", option_silent)
map("n", "<leader>fgb", ":Telescope git_branches<cr>", option_silent)
map("n", "<leader>fm", ":Telescope marks<cr>", option_silent)
map("n", "<leader>fj", ":Telescope jumplist<cr>", option_silent)
map("n", "<leader>fc", ":Telescope lsp_code_actions<cr>", option_silent)
map("n", "<leader>fcs", ":Telescope colorscheme<cr>", option_silent)
map("n", "<leader>cp", ":Telescope neoclip<CR>", option_silent)
map("n", "<leader>cd", ":lua require'telescope'.extensions.zoxide.list{}<CR>", option_silent)
