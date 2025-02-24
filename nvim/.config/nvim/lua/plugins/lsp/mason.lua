--┌─────────────────────────────────────────────────────────────────────────┐--
--│                                 Mason	    															│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- Mason is a package manager for Neovim plugins and LSP servers.
-- What does it do? It installs and manages plugins and LSP servers for you.
-- Note that Mason does not manage communication between the LSP and Neovim, it
-- only installs the LSP servers. The communication part is handled by lspconfig.
-- List of servers for mason to install at:
--
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Language Server Protocol (LSP) servers
		mason_lspconfig.setup({
			-- add new lsp server
			ensure_installed = {
				"lua_ls",
				"bashls",
				"clangd",
				"cmake",
				"pyright",
				"dockerls",
				"fortls",
				-- "autotools_ls",
				"marksman",
				"texlab",
				"ltex",
				-- "textlsp",
				"emmet_ls",
			},
			-- auto-install configured servers (with lspconfig)
			-- Not the same as ensure_installed
			automatic_installation = true,
		})

		-- Linters and Formatters
		mason_tool_installer.setup({
			ensure_installed = {
				-- "prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				-- "black", -- python formatter
				-- "clang-format", -- c/c++ formatter
				-- "latexindent", -- latex formatter (not always useful)
				-- "pylint", -- python linter (use global one instead)
				-- "vale", -- text linter (not useful)
				"cpplint", -- c/c++ linter
				"markdownlint", -- markdown linter
			},
		})
	end,
}
