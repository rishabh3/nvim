local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    execute "packadd packer.nvim"
end

local use = require("packer").use

return require("packer").startup(
    function()
        use "wbthomason/packer.nvim"

        -- Tree
        use {
            "kyazdani42/nvim-tree.lua",
            requires = {
                "kyazdani42/nvim-web-devicons" -- optional, for file icon
            },
            config = function()
                require "nvim-tree".setup {}
            end
        }

        -- startify
        use "mhinz/vim-startify"

        -- snippets
        use "honza/vim-snippets"

        -- colorschemes
        use "projekt0n/github-nvim-theme"
        use "morhetz/gruvbox"

        -- lualine
        use {
            "nvim-lualine/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons"}
        }

        -- Comment
        use "preservim/nerdcommenter"

        -- Telescope
        use "nvim-lua/plenary.nvim"
        use "nvim-telescope/telescope.nvim"

        -- bracket autopairs
        use {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup(
                    {
                        disable_filetype = {"TelescopePrompt", "vim"}
                    }
                )
            end
        }

        -- Plugins for completion
        use {"hrsh7th/nvim-cmp"}
        use {"saadparwaiz1/cmp_luasnip"}
        use {"hrsh7th/cmp-nvim-lsp"}
        use {"hrsh7th/cmp-buffer"}
        use {"hrsh7th/cmp-path"}
        use {"hrsh7th/cmp-cmdline"}
        use {"onsails/lspkind-nvim"}
        use {"hrsh7th/cmp-nvim-lua"}
        use {"L3MON4D3/LuaSnip"}

        -- Language Server
        use {"neovim/nvim-lspconfig"}
		use {
			"glepnir/lspsaga.nvim",
			config = function ()
				require('lspsaga').init_lsp_saga()
			end
		}
        use {"williamboman/nvim-lsp-installer"}
        use {"ray-x/lsp_signature.nvim"}
        use {"mfussenegger/nvim-jdtls"}
        use {"mfussenegger/nvim-dap"}
        use {"mfussenegger/nvim-dap-python"}
        use {
            "rcarriga/nvim-dap-ui",
            requires = {"mfussenegger/nvim-dap"},
            config = function()
                require("dapui").setup()
            end
        }
        use {"nvim-telescope/telescope-dap.nvim"}
		use {'neoclide/coc.nvim', branch = 'release'}

        -- Git
        use {"tpope/vim-fugitive"}
        use {"lewis6991/gitsigns.nvim"}

        -- Treesitter and plugins
        use {"nvim-treesitter/nvim-treesitter"}
        use {"nvim-treesitter/playground"}
        use {"rishabh3/symsearch.nvim"}
        use {"p00f/nvim-ts-rainbow"}

        -- Formatter/Beautify
        use {"kdheepak/tabline.nvim"}
        use {"mhartington/formatter.nvim"}
        use {"lukas-reineke/indent-blankline.nvim"}

        -- Notify Plugin
        use {"rcarriga/nvim-notify"}

        -- Neoclip
        use {
            "AckslD/nvim-neoclip.lua",
            config = function()
                require("neoclip").setup()
            end
        }
        -- Zoxide
        use {"jvgrootveld/telescope-zoxide"}

        -- Lightspeed line
        use {"ggandor/lightspeed.nvim"}

        -- Diagnositcs
        use {"folke/trouble.nvim"}

		-- Dispatch for async builds and test executions
		use {"tpope/vim-dispatch"}

		-- Project management
		use {"ahmedkhalf/project.nvim"}

		-- Symbol outline
		use {"simrat39/symbols-outline.nvim"}
    end
)
