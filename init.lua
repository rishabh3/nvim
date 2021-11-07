require('plugins')
require('keymaps')
-- require('coc')
require('settings')
-- require('lsp.lua-ls')
require('colorscheme')
require('airline')


-- Set up nvim-jdtls
vim.api.nvim_exec([[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'lsp.jdtls_config'.setup()
    augroup end
]], true)
