-- Treesitter
-- Syntax highlighting and indentation based on treesitter
-- List of available parsers:
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages

return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- no releases (repo archived Apr 2026, main branch is frozen)
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
        version = false, -- no releases
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
        version = false, -- no releases
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
-- FALLBACK: 'master' branch configuration (old API, pre-2025 style)
-- To switch: comment out the active return{} block above, uncomment this block.
-- NOTE: nvim-treesitter/nvim-treesitter was archived Apr 3, 2026 (read-only).
--       Both main and master are frozen. 'main' is the recommended active config.
--
-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	version = false,
-- 	branch = "master",
-- 	build = ":TSUpdate",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	dependencies = {
-- 		{ "windwp/nvim-ts-autotag", version = false }, -- auto close/rename html tags
-- 	},
-- 	config = function()
-- 		local tsconfig = require("nvim-treesitter.configs")
-- 		tsconfig.setup({
-- 			-- Enable indentation
-- 			indent = { enable = true },
-- 			-- Enable syntax highlighting
-- 			highlight = {
-- 				enable = true,
-- 				additional_vim_regex_highlighting = false,
-- 			},
-- 			-- Enable autotagging (handled via the dependency above)
-- 			autotag = { enable = true },
-- 			-- Parsers to install (keep in sync with main branch list above)
-- 			ensure_installed = {
-- 				"python",
-- 				"cpp",
-- 				"cmake",
-- 				"dockerfile",
-- 				"bash",
-- 				"fortran",
-- 				"markdown",
-- 				"latex",
-- 				-- Always install these five
-- 				"lua",
-- 				"vim",
-- 				"vimdoc",
-- 				"c",
-- 				"query",
-- 			},
-- 			-- Incremental selection keymaps
-- 			incremental_selection = {
-- 				enable = true,
-- 				keymaps = {
-- 					init_selection = "<C-space>",
-- 					node_incremental = "<C-space>",
-- 					scope_incremental = false,
-- 					node_decremental = "<bs>",
-- 				},
-- 			},
-- 		})
-- 	end,
-- }
