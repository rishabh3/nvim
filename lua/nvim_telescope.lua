    local utils = require("utils")
    local map = utils.map

    map(
        "n",
        "<leader>ff",
        ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ winblend = 10 }))<cr>",
        {noremap = true, silent = true}
    )

    map(
        "n",
        "<leader>fg",
        ":lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({ winblend = 10 }))<cr>",
        {noremap = true, silent = true}
    )

    map(
        "n",
        "<leader>fk",
        ":lua require'telescope.builtin'.keymaps(require('telescope.themes').get_cursor())<cr>",
        {noremap = true, silent = true}
    )

    map(
        "n",
        "<leader>fr",
        ":lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_cursor())<cr>",
        {noremap = true, silent = true}
    )

    map(
        "n",
        "<leader>fd",
        ":lua require'telescope.builtin'.lsp_definitions(require('telescope.themes').get_cursor())<cr>",
        {noremap = true, silent = true}
    )

    map(
        "n",
        "<leader>ftd",
        ":lua require'telescope.builtin'.lsp_type_definitions(require('telescope.themes').get_cursor())<cr>",
        {noremap = true, silent = true}
    )

    map(
        "n",
        "<leader>fi",
        ":lua require'telescope.builtin'.lsp_implementations(require('telescope.themes').get_cursor())<cr>",
        {noremap = true, silent = true}
    )

    map("n", "<leader>fb", ":Telescope buffers<cr>", {noremap = true, silent = true})
    map("n", "<leader>fh", ":Telescope help_tags<cr>", {noremap = true, silent = true})
    map("n", "<leader>fgs", ":Telescope git_status<cr>", {noremap = true, silent = true})
    map("n", "<leader>fgc", ":Telescope git_commits<cr>", {noremap = true, silent = true})
    map("n", "<leader>fm", ":Telescope marks<cr>", {noremap = true, silent = true})
    map("n", "<leader>fj", ":Telescope jumplist<cr>", {noremap = true, silent = true})
    map("n", "<leader>fc", ":Telescope lsp_code_actions<cr>", {noremap = true, silent = true})
    map("n", "<leader>fcs", ":Telescope colorscheme<cr>", {noremap = true, silent = true})
    map("n", "<leader>ft", ":Telescope file_browser <cr>", {noremap = true, silent = true})

