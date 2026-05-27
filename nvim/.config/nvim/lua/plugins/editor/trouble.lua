-- Trouble
-- Manage erros, warnings, diagnostics, and more.														 --

return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {},
	cmd = "Trouble",
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open/close trouble list" },
		{ "<leader>xd", "<cmd>Trouble diagnostics<CR>", desc = "Open trouble document diagnostics" },
		{ "<leader>xq", "<cmd>Trouble quickfix<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist<CR>", desc = "Open trouble location list" },
		{ "<leader>xt", "<cmd>Trouble todo<CR>", desc = "Open todos in trouble" },
	},
}
