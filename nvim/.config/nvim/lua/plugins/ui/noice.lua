-- Noice
-- Replaces the UI for messages, cmdline and popupmenu
-- Also improves LSP hover documentation rendering via Treesitter

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",           -- required: rendering backend
		"rcarriga/nvim-notify",            -- optional: richer notification view
	},
	opts = {
		lsp = {
			-- Keep noice's treesitter-based markdown rendering for cmp docs.
			-- convert_input_to_markdown_lines and stylize_markdown are intentionally
			-- NOT overridden here: letting Neovim own those functions means Neovim
			-- also owns the hover window lifecycle, which fixes the "hover only works
			-- once" bug caused by noice deduplicating already-seen hover messages.
			override = {

                -- XXX: not working...
                -- Override the default LSP markdown formatter with Noice + Treesitter.
                -- This fixes Doxygen tags (\\brief, \\param, etc.) and renders hover
                -- docs properly instead of showing raw markdown in a floating buffer.
				-- ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				-- ["vim.lsp.util.stylize_markdown"] = true,

				["vim.lsp.util.convert_input_to_markdown_lines"] = false,
				["vim.lsp.util.stylize_markdown"] = false,
				["cmp.entry.get_documentation"] = false,
			},
			-- Let Neovim manage the hover window; noice must not intercept it.
			hover = { enabled = false },
			signature = { enabled = false },

            -- XXX: not working...
			-- -- Fix "hover only works once" issue (Neovim 0.11+):
			-- -- replace = true (default) tries to reuse the previous hover message;
			-- -- when that window is already gone, it silently fails. replace = false
			-- -- always creates a fresh window on every K press.
			-- documentation = {
			-- 	opts = { replace = false },
			-- },
		},
		presets = {
			bottom_search = true,         -- classic bottom cmdline for / and ?
			command_palette = false,      -- disable top-center positioning
			long_message_to_split = true, -- send long messages to a split buffer
			lsp_doc_border = true,        -- add a border to hover and signature help
		},
		-- Suppress the default "X lines written" message (replaced by our notify call)
		routes = {
			{
				filter = { event = "msg_show", kind = "", find = "written" },
				opts = { skip = true },
			},
		},
		-- Position the cmdline popup near the bottom of the editor
		views = {
			cmdline_popup = {
				position = { row = "90%", col = "50%" },
				size = { min_width = 60, width = "auto", height = "auto" },
			},
			popupmenu = {
				relative = "editor",
				position = { row = "90%", col = "50%" },
				size = { width = 60, height = 10 },
				border = { style = "rounded", padding = { 0, 1 } },
			},
		},
	},
}
