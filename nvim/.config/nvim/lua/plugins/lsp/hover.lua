-- hover.nvim
-- Framework for context-aware hover providers.
-- Replaces vim.lsp.buf.hover with a multi-source hover that also shows
-- diagnostics, man pages and more. Binds K globally (not per-buffer).

return {
	"lewis6991/hover.nvim",
	version = false, -- no releases
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hover").setup({
			providers = {
				"hover.providers.lsp", -- LSP hover (primary)
				"hover.providers.diagnostic", -- inline diagnostics on the line
				"hover.providers.man", -- man-page entries
			},
			preview_opts = {
				border = "rounded",
			},
			preview_window = false, -- press K again to move docs to a preview window
			title = true, -- show source name (e.g. "LSP") in the popup title
		})

		-- K opens hover; pressing K again enters the floating window
		vim.keymap.set("n", "K", require("hover").open, { desc = "Show hover documentation" })
		vim.keymap.set("n", "gK", require("hover").enter, { desc = "Enter hover window" })

		-- Cycle through providers when multiple are available
		vim.keymap.set("n", "<C-p>", function()
			require("hover").switch("previous")
		end, { desc = "Hover: previous source" })

		vim.keymap.set("n", "<C-n>", function()
			require("hover").switch("next")
		end, { desc = "Hover: next source" })

		-- Dynamically color the hover border/title based on the worst diagnostic
		-- severity on the cursor line. Falls back to the default FloatBorder when
		-- there are no diagnostics (e.g. when showing plain LSP docs).
		local severity_hl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticFloatingError",
			[vim.diagnostic.severity.WARN] = "DiagnosticFloatingWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticFloatingInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticFloatingHint",
		}

		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				local bufnr = vim.api.nvim_get_current_buf()
				local row = vim.api.nvim_win_get_cursor(0)[1] - 1
				local diags = vim.diagnostic.get(bufnr, { lnum = row })

				local hl = "FloatBorder" -- default when no diagnostics
				if #diags > 0 then
					-- Find the highest severity (lowest numeric value)
					local worst = diags[1].severity
					for _, d in ipairs(diags) do
						if d.severity < worst then
							worst = d.severity
						end
					end
					hl = severity_hl[worst] or "FloatBorder"
				end

				vim.api.nvim_set_hl(0, "HoverBorder", { link = hl })
				vim.api.nvim_set_hl(0, "HoverActiveSource", { link = hl })
			end,
		})
	end,
}
