local utils = require("utils")
local map = utils.map
local prefix = "→ "

require "telescope".setup {
    pickers = {
        find_files = {
            winblend = 10,
            prompt_prefix = prefix,
            selection_caret = prefix,
            dynamic_preview_title = true
        },
        file_browser = {
            theme = "ivy",
            winblend = 10,
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        live_grep = {
            theme = "ivy",
            prompt_prefix = prefix,
            selection_caret = prefix,
            winblend = 10
        },
        keymaps = {
            theme = "cursor",
            winblend = 20,
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_references = {
            theme = "ivy",
            winblend = 20,
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_type_definitions = {
            theme = "cursor",
            winblend = 20,
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_definitions = {
            theme = "cursor",
            winblend = 20,
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        lsp_implementations = {
            theme = "ivy",
            winblend = 20,
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        buffers = {
            theme = "ivy",
            winblend = 20,
            prompt_prefix = prefix,
            selection_caret = prefix
        },
        git_branches = {
            theme = 'cursor',
            winblend = 10,
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
            winblend = 10,
        }
    }
}

map("n", "<leader>ff", ":lua require'telescope.builtin'.find_files()<cr>", {noremap = true, silent = true})

map("n", "<leader>fg", ":lua require'telescope.builtin'.live_grep()<cr>", {noremap = true, silent = true})

map("n", "<leader>fk", ":lua require'telescope.builtin'.keymaps()<cr>", {noremap = true, silent = true})

map("n", "<leader>fr", ":lua require'telescope.builtin'.lsp_references()<cr>", {noremap = true, silent = true})

map("n", "<leader>fd", ":lua require'telescope.builtin'.lsp_definitions()<cr>", {noremap = true, silent = true})

map("n", "<leader>ftd", ":lua require'telescope.builtin'.lsp_type_definitions()<cr>", {noremap = true, silent = true})

map("n", "<leader>fi", ":lua require'telescope.builtin'.lsp_implementations()<cr>", {noremap = true, silent = true})

map("n", "<leader>fb", ":Telescope buffers<cr>", {noremap = true, silent = true})
map("n", "<leader>fh", ":Telescope help_tags<cr>", {noremap = true, silent = true})
map("n", "<leader>fgs", ":Telescope git_status<cr>", {noremap = true, silent = true})
map("n", "<leader>fgc", ":Telescope git_commits<cr>", {noremap = true, silent = true})
map("n", "<leader>fgb", ":Telescope git_branches<cr>", {noremap = true, silent = true})
map("n", "<leader>fm", ":Telescope marks<cr>", {noremap = true, silent = true})
map("n", "<leader>fj", ":Telescope jumplist<cr>", {noremap = true, silent = true})
map("n", "<leader>fc", ":Telescope lsp_code_actions<cr>", {noremap = true, silent = true})
map("n", "<leader>fcs", ":Telescope colorscheme<cr>", {noremap = true, silent = true})
map("n", "<leader>ft", ":Telescope file_browser <cr>", {noremap = true, silent = true})
