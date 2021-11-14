local prefix = "→ "

require'telescope'.setup {
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
