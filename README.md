**NVIM CONFIGURATION**
=======================

## Support
- **Packer**: Plugin Management Utility
- **Lspconfig**: LSPconfig for maintaining or using native lsp support.
- **NVIM-JDTLS**: java lsp support, as it provides features to run and debug testcases.
- **Formatter**: Formatting via external programs like prettier etc.
- **DAP**: Debugging support inside nvim with UI for viewing variables.
- **Telescope**: Fuzzy finder providing various capabilities like keymaps, help, browser, find files,
live grep and many more.
- **Nerdtree**: As a file browser support providing file system functions.
- **Startify**: For opening a starting page on startup showing last worked files.
- **Snippets**: Snippets for quick workflow
- **Fugitive**: Git integration
- **Git signs**: Git lens like feature of vscode
- **Airline**: Status line themes
- **Material**: Material theme support
- **Gruvbox**: Gruvbox theme support
- **Kommentary**: Quick comments on few keystrokes
- **vim-test**: Running test quickly
- **ack**: Grepping string over project
- **LspInstaller**: Installing Lsp servers
- **DAPInstall**: Install debuggers for languages
- **Dap UI**: DAP UI support
- **Lightspeed**: Quick search and jump in the buffer
- **Tabline**: Tabline for clean tabs
- **SymSearch**: SymSearch for symbol searching 

## Files and Importance
- **lua**: Directory containing all lua configuration files.
- **lua/airline.lua**: Airline configuration, add more airline releated configs in this file.
- **lua/colorscheme.lua**: Colorschem configuration
- **lua/completion.lua**: Autocompletion configuration
- **lua/devicons.lua**: Devicons configuration
- **lua/gitsign.lua**: Git sign configuration
- **lua/keymaps.lua**: Keybinds I use
- **lua/nvim_dap.lua**: DAP configs
- **lua/nvim_dap_install.lua**: Dap install configs
- **lua/nvim_formatter.lua**: Formatter configs
- **lua/nvim_java.lua**: Java support
- **lua/nvim_lsp.lua**: Lspconfig support
- **lua/nvim_rooter.lua**: Rooter configs
- **lua/nvim_telescope_config.lua**: Telescope configuration
- **lua/treesitter_config.lua**: Treesitter configuration
- **lua/plugins.lua**: All plugins supported
- **lua/settings.lua**: vim settings
- **lua/utils/init.lua**: Utility function
- **lua/tabline_config.lua**: Tabline configuration
- **lua/nvim_symsearch_config.lua**: Symsearch configuration
- **init.lua**: Init file for neovim
- **plugin**: Directory containing plugins for old vim based supported configs
- **plugin/ack.vim**: Ack plugin configs
- **plugin/colorsetting.vim**: Colorsetting configs
- **plugin/fugitive.vim**: Fugitive configs and keymaps
- **plugin/keybind.vim**: Old vim keybinds
- **plugin/vim-test.vim**: Vim test configs and keybinds
- **plugin/packer_compiled.lua**: All compiled packer plugins


**NOTE**: README.md file in specific plugins github repository provide enough basic configuration to build support.
