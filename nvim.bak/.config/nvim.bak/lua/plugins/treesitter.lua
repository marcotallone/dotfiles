--┌─────────────────────────────────────────────────────────────────────────┐--
--│                               Treesitter	  														│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- Syntax highlighting and indentation based on treesitter                   --
-- List of available parsers:
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	-- dependencies = {
	-- 	"windwp/nvim-ts-autotag", -- Auto close and auto rename html tags
	-- },
	config = function()
		local config = require("nvim-treesitter.configs")

		config.setup({

			-- Enable indentation
			indent = {
				enable = true,
			},

			-- Enable syntax highlighting
			highlight = {
				enable = true,
			},

			-- Enable autotagging (w/ nvim-ts-autotag plugin)
			-- autotag = {
			--   enable = true,
			-- },

			-- Ensure these language parser are installed
			ensure_installed = {
				"lua",
				"python",
				"c",
				"cpp",
				"cmake",
				"dockerfile",
				"bash",
				"fortran",
				"markdown",
				"latex",
				"vim",
				"vimdoc",
			},

			-- Keymaps for incremental selection based on the language syntax
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
