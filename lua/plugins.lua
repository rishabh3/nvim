local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local use = require('packer').use

return require('packer').startup(function()
  -- Packer can manage itself
    use { 'nvim-telescope/telescope-project.nvim' }
    --    use { 'neoclide/coc.nvim', branch='release' } 
    use { 'scrooloose/nerdtree' }
    use { 'honza/vim-snippets' }
    use { 'mhinz/vim-startify' }
    use { 'vim-airline/vim-airline' }
    use { 'vim-airline/vim-airline-themes' }
    use { 'preservim/nerdcommenter' }
    use { 'ryanoasis/vim-devicons' }
    use { 'morhetz/gruvbox' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim' }
    use { 'vim-test/vim-test' }
    use { 'tpope/vim-dispatch' }
    use { 'tpope/vim-fugitive' }
    use { 'GlennLeo/cobalt2' }
    use { 'airblade/vim-gitgutter' }
    use { 'mileszs/ack.vim' }
    use { 'mfussenegger/nvim-dap' }
    use { 'nvim-lua/lsp-status.nvim' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'onsails/lspkind-nvim' }
    use { 'dcampos/cmp-snippy' }
    use { 'glepnir/lspsaga.nvim' }
    use { 'b3nj5m1n/kommentary' }
    use { 'mhartington/formatter.nvim' }
    use { 'mfussenegger/nvim-jdtls' }
end)
