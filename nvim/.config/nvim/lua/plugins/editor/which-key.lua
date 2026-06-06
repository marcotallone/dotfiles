-- Which Key
-- Displays a popup with possible keybindings of the command you started typing

return {
	"folke/which-key.nvim",
	dependencies = {
		{ "echasnovski/mini.nvim", version = false },
	},
	-- event = "VeryLazy",
	lazy = false, -- to see suggestions as typing
	-- This function obliges nvim to wait half a second after each keypress
	-- to see if you're typing a key sequence (like <leader>sv)
	-- and hence facilitate keys display
	init = function()
		vim.o.timeout = false -- NOTE: set to 'true' to activate
		vim.o.timeoutlen = 500
	end,
	opts = {},
}
