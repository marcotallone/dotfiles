-- Treesitter
-- Syntax highlighting and indentation based on treesitter
-- List of available parsers:
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()

            -- Install parsers
            -- The "ensure_installed" option is gone (2026, new `main` branch)
            -- We must manually call install
            require("nvim-treesitter").install{
                "python",
                "cpp",
                "cmake",
                "dockerfile",
                "bash",
                "fortran",
                "markdown",
                "latex",
                -- The five parsers below should ALWAYS be installed
                "lua",
                "vim",
                "vimdoc",
                "c",
                "query"
            }

            -- Enable features (Highlighting & Indentation)
            -- These are now controlled by Neovim options, not the plugin setup
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
                callback = function(args)
                    -- Enable Highlighting (equivalent to old highlight.enable = true)
                    -- NOTE: Neovim 0.11+ might do this automatically, but this ensures it
                    pcall(vim.treesitter.start, args.buf)

                    -- Enable Indentation (equivalent to old indent.enable = true)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },

    -- Separate plugin: Auto-Tagging
    -- This must be configured separately now
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-ts-autotag").setup({
                -- options: enable_close, enable_rename, etc...
            })
        end,
    },

    -- Separate plugin: Incremental Selection
    -- This feature was removed from core
    -- You need "treesitter-modules" to restore it
    {
        "MeanderingProgrammer/treesitter-modules.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
    },
}



--------------------------------------------------------------------------------
-- -- OLD: old 'master' branch configuration (for backwards compatibility)
-- return {
	-- "nvim-treesitter/nvim-treesitter",
	-- event = { "BufReadPre", "BufNewFile" },
	-- build = ":TSUpdate",
    -- branch = "master",
	-- dependencies = {
	-- 	"windwp/nvim-ts-autotag", -- Auto close and auto rename html tags
	-- },

	-- config = function()
	-- 	local config = require("nvim-treesitter.configs")

	-- 	config.setup({

	-- 		-- Enable indentation
	-- 		indent = {
	-- 			enable = true,
	-- 		},

	-- 		-- Enable syntax highlighting
	-- 		highlight = {
	-- 			enable = true,
    --             -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    --             -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    --             -- Using this option may slow down your editor, and you may see some duplicate highlights.
    --             -- Instead of true it can also be a list of languages
    --             additional_vim_regex_highlighting = false,
	-- 		},

	-- 		-- Enable autotagging (with nvim-ts-autotag plugin)
	-- 		autotag = {
	-- 		  enable = true,
	-- 		},

	-- 		-- Ensure these language parser are installed
	-- 		ensure_installed = {
	-- 			"lua",
	-- 			"python",
	-- 			"c",
	-- 			"cpp",
	-- 			"cmake",
	-- 			"dockerfile",
	-- 			"bash",
	-- 			"fortran",
	-- 			"markdown",
	-- 			"latex",
	-- 			"vim",
	-- 			"vimdoc",
	-- 		},

	-- 		-- Keymaps for incremental selection based on the language syntax
	-- 		incremental_selection = {
	-- 			enable = true,
	-- 			keymaps = {
	-- 				init_selection = "<C-space>",
	-- 				node_incremental = "<C-space>",
	-- 				scope_incremental = false,
	-- 				node_decremental = "<bs>",
	-- 			},
	-- 		},
	-- 	})
	-- end,
-- }
