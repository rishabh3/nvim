require("plugins")
require("nvim_formatter")
require("keymaps")
-- require('coc')
require("settings")
-- require('lsp.lua-ls')
require("colorscheme")
require("airline")
require("completion")
require("devicons")
require("nvim_lsp")
require("gitsign")
require("nvim_rooter")
require("treesitter_config")
require("nvim_dap_install")
require("nvim_dap")
require("nvim_telescope_config")
require("tabline_config")
require("nvim_symsearch_config")

vim.api.nvim_exec(
    [[augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'nvim_java'.setup()
augroup end]],
    false
)
