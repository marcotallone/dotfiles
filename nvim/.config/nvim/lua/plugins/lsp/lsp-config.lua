-- LSP Config
-- This configures the LSP servers using lspconfig.
-- It makes communications possible between Neovim and LSP servers.
-- It handles autocompletion, diagnostics, and keybinds for LSP servers.
-- It also configures the diagnostic symbols in the sign column (gutter).

return {
	"neovim/nvim-lspconfig",
	-- version = false, -- if desired, use HEAD for latest server configurations
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- Keymaps (only active when LSP is attached to buffer)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local opts = { noremap = true, silent = true, buffer = bufnr }

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Enable autocompletion (assign to every lsp server config)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("*", { capabilities = capabilities }) -- apply to all servers at once

		-- Configure LSP servers
		vim.lsp.enable({
			"bashls",
			"cmake",
			"dockerls",
			"fortls",
			"marksman",
			"autotools_ls",
			"texlab",
			"emmet_ls",
			"html",
			"lua_ls",
		})

		-- Servers that need extra settings
        vim.lsp.config("clangd", {
            -- NOTE: According to https://clangd.llvm.org/troubleshooting
            -- It is recommended to use --query-driver over specifying system 
            -- include paths manually as getting the latter right can be tricky 
            -- (order of include paths matters).
            cmd = {
                "clangd",
                "--query-driver=/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang,/usr/bin/clang++",
            },
        })
        vim.lsp.enable("clangd")

		vim.lsp.config("ltex", {
			filetypes = { "tex" }, -- ltex only targets LaTeX, not plain text
		})
		vim.lsp.enable("ltex")

		vim.lsp.config("pyright", {
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
		vim.lsp.enable("pyright")

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							-- make language server aware of runtime files
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- Change the diagnostic symbols in the sign column (gutter)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

        -- FIXME:
		-- -- Post-process LSP hover responses to clean up raw Doxygen tags
		-- -- that clangd passes through without converting (\brief, \param, etc.)
		-- local orig_hover = vim.lsp.handlers["textDocument/hover"]
		-- vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
		-- 	if result and result.contents then
		-- 		local function clean_doxygen(text)
		-- 			if type(text) ~= "string" then return text end
		-- 			-- Strip bare section-marker tags (content follows on same line)
		-- 			text = text:gsub("\\brief%s+", "")
		-- 			text = text:gsub("\\details%s+", "")
		-- 			text = text:gsub("\\short%s+", "")
		-- 			-- Normalise \param[in], \param[out], \param[in,out] → \param
		-- 			text = text:gsub("\\param%[.-%]%s+", "\\param ")
		-- 			-- Format \param name description → - **`name`**: description
		-- 			text = text:gsub("\\param%s+(%S+)%s+", "- **`%1`**: ")
		-- 			-- Format \return / \returns
		-- 			text = text:gsub("\\returns?%s+", "**Returns:** ")
		-- 			-- Format \see / \sa
		-- 			text = text:gsub("\\see%s+", "**See also:** ")
		-- 			text = text:gsub("\\sa%s+", "**See also:** ")
		-- 			-- Format \note and \warning as blockquotes
		-- 			text = text:gsub("\\note%s+", "> **Note:** ")
		-- 			text = text:gsub("\\warning%s+", "> **Warning:** ")
		-- 			-- Format \deprecated
		-- 			text = text:gsub("\\deprecated%s+", "> **Deprecated:** ")
		-- 			-- Format \throw / \throws
		-- 			text = text:gsub("\\throws?%s+(%S+)%s+", "**Throws** `%1`: ")
		-- 			return text
		-- 		end
		-- 		if type(result.contents) == "string" then
		-- 			result.contents = clean_doxygen(result.contents)
		-- 		elseif type(result.contents) == "table" and result.contents.value then
		-- 			result.contents.value = clean_doxygen(result.contents.value)
		-- 		end
		-- 	end
		-- 	return orig_hover(err, result, ctx, config)
		-- end	

    end,
}
