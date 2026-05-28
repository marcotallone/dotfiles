-- Formatting
-- Code formatting using 'conform'

-- NOTE: To apply personalized cland formatting for C/C++ remember to stow clangd
--       configuration in dotfiles

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			-- NOTE: You might not always want to enable formatters
			--       as they can change the code in ways you might not want.
			--       Enable only the ones you want by uncommenting them.
			formatters_by_ft = {
				-- javascript = { "prettier" },
				-- typescript = { "prettier" },
				-- javascriptreact = { "prettier" },
				-- typescriptreact = { "prettier" },
				-- svelte = { "prettier" },
				-- css = { "prettier" },
				-- html = { "prettier" },
				-- json = { "prettier" },
				-- yaml = { "prettier" },
				markdown = { "markdownlint" },
				lua = { "stylua" },
				python = { "isort", "black" },
				-- latex = { "latexindent" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
			format_on_save = { -- enable format on save
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
