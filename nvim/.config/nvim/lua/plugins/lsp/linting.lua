-- Linting
-- Code linting using 'nvim-lint'

return {
	"mfussenegger/nvim-lint",
	version = false, -- no releases
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- NOTE: You might not always want to enable linters.
		--       Enable only the ones you want by uncommenting them.
		lint.linters_by_ft = {
			-- javascript = { "eslint_d" },
			-- typescript = { "eslint_d" },
			-- javascriptreact = { "eslint_d" },
			-- typescriptreact = { "eslint_d" },
			-- svelte = { "eslint_d" },
			python = { "pylint" },
			latex = { "chktex" },
			tex = { "chktex" },
			markdown = { "markdownlint" },
			-- text = { "vale" },
			-- c = { "cpplint" },
			-- cpp = { "cpplint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				-- lint.try_lint()
				-- NOTE: try_lint has an ignore_errors option to ignore command-not-found errors
				lint.try_lint(nil, { ignore_errors = true })
			end,
		})

		vim.keymap.set("n", "<leader>ml", function()
			-- lint.try_lint()
			lint.try_lint(nil, { ignore_errors = true })
		end, { desc = "Trigger linting for current file" })
	end,
}
