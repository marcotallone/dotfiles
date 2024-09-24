--┌─────────────────────────────────────────────────────────────────────────┐--
--│                               LSP Config  															│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- This configures the LSP servers using lspconfig.
-- It makes communications possible between Neovim and LSP servers.
-- It handles autocompletion, diagnostics, and keybinds for LSP servers.
-- It also configures the diagnostic symbols in the sign column (gutter).

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Local Variables
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp") -- nvim-cmp for autocompletion
		local mason_lspconfig = require("mason-lspconfig") -- mason lspconfig
		local keymap = vim.keymap -- for conciseness

		-- Keymaps (only active when LSP is attached to buffer)
		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		-- Enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Configure LSP servers
		lspconfig["bashls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["cmake"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["dockerls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["fortls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["marksman"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["autotools_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						typeCheckingMode = "basic",
					},
					pythonPath = "/usr/bin/python",
				},
			},
		})

		lspconfig["texlab"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["ltex"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "txt", "tex" },
		})

		lspconfig["textlsp"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- filetypes = { "txt", "tex" }, -- Specify the file types for textlsp
		})

		-- Start and stop textlsp on command (sometimes it's annyoing that's why...)
		keymap.set(
			"n",
			"<leader>kl",
			":LspStart textlsp<CR>",
			{ noremap = true, silent = true, desc = "Start Text LSP" }
		)
		keymap.set("n", "<leader>kk", ":LspStop textlsp<CR>", { noremap = true, silent = true, desc = "Stop Text LSP" })

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})

		lspconfig["html"].setup({
			capabilities = capabilities,
			filetypes = {
				"html",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})
		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
