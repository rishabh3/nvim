local M = {}

function M.setup()
    local on_attach = function(client, bufnr)
        require "jdtls".setup_dap()
		require "lsp_signature".on_attach()
        require "jdtls.setup".add_commands()
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = {noremap = true, silent = true}
        buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
        -- Java specific
        buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
        buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
        buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
        buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
        buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
        buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
        buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        vim.api.nvim_exec(
            [[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
      ]],
            false
        )

		vim.notify("Started jdtls client")
    end

    local root_markers = {".git", "gradlew", "pom.xml"}
    local root_dir = require("jdtls.setup").find_root(root_markers)
    local home = os.getenv("HOME")

    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }

    local workspace_folder = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = {
        flags = {
            allow_incremental_sync = true
        },
        capabilities = capabilities,
        on_attach = on_attach
    }

    config.settings = {
        java = {
            signatureHelp = {enabled = true},
            contentProvider = {preferred = "fernflower"},
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999
                }
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = os.getenv("JAVA_HOME")
                    }
                }
            }
        }
    }

    config.cmd = {"launch_jdtls", workspace_folder}
    config.on_attach = on_attach

    config.on_init = function(client, _)
        client.notify("workspace/didChangeConfiguration", {settings = client.config.settings})
    end

    local extendedClientCapabilities = require "jdtls".extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
        -- bundles = bundles;
        extendedClientCapabilities = extendedClientCapabilities
    }

    -- UI
    --local finders = require "telescope.finders"
    --local sorters = require "telescope.sorters"
    --local actions = require "telescope.actions"
    --local pickers = require "telescope.pickers"
    --local action_state = require "telescope.actions.state"

    --require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
    --local opts = {}
    --pickers.new(
    --opts,
    --{
    --prompt_title = prompt,
    --finder = finders.new_table {
    --results = items,
    --entry_maker = function(entry)
    --return {
    --value = entry,
    --display = label_fn(entry),
    --ordinal = label_fn(entry)
    --}
    --end
    --},
    --sorter = sorters.get_generic_fuzzy_sorter(),
    --attach_mappings = function(prompt_bufnr)
    --actions.select_default:replace(
    --function()
    --local selection = action_state.get_selected_entry(prompt_bufnr)

    --actions.close(prompt_bufnr)

    --cb(selection.value)
    --end
    --)

    --return true
    --end
    --}
    --):find()
    --end

    -- Debugger Support
    -- This bundles definition is the same as in the previous section (java-debug installation)
    local bundles = {
        vim.fn.glob(
            home ..
                "/.local/java_debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
        )
    }

    -- This is the new part
    vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/java_debug/vscode-java-test/server/*.jar"), "\n"))
    config["init_options"] = {
        bundles = bundles
    }

    -- Server
    require("jdtls").start_or_attach(config)
end

M.setup()
