--┌─────────────────────────────────────────────────────────────────────────┐--
--│                                 Trouble	  															│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- Manage erros, warnings, diagnostics, and more.														 --

return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {},
	cmd = "Trouble",
	keys = {
		-- (Old)
		-- { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
		-- { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
		-- { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
		-- { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
		-- { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
		-- { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open/close trouble list" },
		{ "<leader>xd", "<cmd>Trouble diagnostics<CR>", desc = "Open trouble document diagnostics" },
		{ "<leader>xq", "<cmd>Trouble quickfix<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist<CR>", desc = "Open trouble location list" },
		{ "<leader>xt", "<cmd>Trouble todo<CR>", desc = "Open todos in trouble" },
	},
}
