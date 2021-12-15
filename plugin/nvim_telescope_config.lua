local actions = require('telescope.actions')
local prefix = "→ "


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
        },
        file_browser = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix
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
