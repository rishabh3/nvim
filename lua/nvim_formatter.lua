require("formatter").setup(
    {
        filetype = {
            javascript = {
                function()
                    return {
                        exe = "prettier",
                        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
                        stdin = true
                    }
                end
            },
            typescript = {
                function()
                    return {
                        exe = "prettier",
                        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
                        stdin = true
                    }
                end
            },
            rust = {
                function()
                    return {
                        exe = "rustfmt",
                        args = {"--emit=stdout"},
                        stdin = true
                    }
                end
            },
            lua = {
                function()
                    return {
                        exe = "luafmt",
                        args = {"--indent-count", 4, "--stdin"},
                        stdin = true
                    }
                end
            },
            python = {
                function()
                    return {
                        exe = "python3 -m autopep8",
                        args = {
                            "--in-place --aggressive --aggressive",
                            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                        },
                        stdin = false
                    }
                end
            }
        }
    }
)
