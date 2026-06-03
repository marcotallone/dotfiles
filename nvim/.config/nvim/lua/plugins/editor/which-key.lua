-- Which Key
-- Displays a popup with possible keybindings of the command you started typing

return {
	"folke/which-key.nvim",
	dependencies = {
		{ "echasnovski/mini.nvim", version = false },
	},
	-- event = "VeryLazy",
	lazy = false, -- to see suggestions as typing
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {},
}
