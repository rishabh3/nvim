local get_folder = function()
    local root_markers = {"gradlew", "pom.xml"}
    local root_dir = require("jdtls.setup").find_root(root_markers)
    local workspace_folder = vim.fn.fnamemodify(root_dir, ":p:h:t")
    return workspace_folder
end

local capabilities = {
    workspace = {
        configuration = true
    },
    textdocument = {
        completion = {
            completionitem = {
                snippetsupport = true
            }
        }
    }
}

local extendedClientCapabilities = require "jdtls".extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local home = os.getenv("HOME")

local bundles = {
    vim.fn.glob(
        home ..
            "/.local/java_debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    )
}
-- This is the new part
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/java_debug/vscode-java-test/server/*.jar"), "\n"))

require "navigator".setup(
    {
        debug = false,
        width = 0.8,
        height = 0.4,
        preview_height = 0.45,
        lsp_installer = true,
        lsp = {
            code_action = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
            code_lens_action = {enable = true, sign = true, sign_priority = 40, virtual_text = true},
            format_on_save = false,
            jdtls = {
                filetypes = {"java"},
                cmd = {"launch_jdtls", get_folder()},
				root_directory = function ()
					local root_markers = {"gradlew", "pom.xml"}
					return require("jdtls.setup").find_root(root_markers)
				end,
                flags = {
                    allow_incremental_sync = true
                },
                capabilities = capabilities,
                settings = {
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
                },
                on_init = function(client, _)
                    client.notify("workspace/didChangeConfiguration", {settings = client.config.settings})
                end,
                init_options = {
                    extendedClientCapabilities = extendedClientCapabilities,
                    bundles = bundles
                },
                on_attach = function(client, bufnr)
                    vim.notify("attached jdtls to client")
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

                    -- mappings.
                    local opts = {noremap = true, silent = true}
                    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
                    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
                    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
                    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
                    buf_set_keymap(
                        "n",
                        "<leader>wl",
                        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                        opts
                    )
                    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
                    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
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
							  hi lspreferenceread cterm=bold ctermbg=red guibg=lightyellow
							  hi lspreferencetext cterm=bold ctermbg=red guibg=lightyellow
							  hi lspreferencewrite cterm=bold ctermbg=red guibg=lightyellow
							  augroup lsp_document_highlight
								autocmd!
								autocmd cursorhold <buffer> lua vim.lsp.buf.document_highlight()
								autocmd cursormoved <buffer> lua vim.lsp.buf.clear_references()
							  augroup end
						  ]],
                        false
                    )
                end
            }
        }
    }
)
