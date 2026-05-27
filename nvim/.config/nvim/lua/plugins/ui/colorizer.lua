-- Colorizer
-- A plugin that colorizes the hex codes in your code

return {
	"brenoprata10/nvim-highlight-colors",
	version = false, -- no tags available
	event = "VeryLazy", -- utility plugin, lazy load
	config = function()
		require("nvim-highlight-colors").setup()
	end,
}
