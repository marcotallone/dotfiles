-- Colorizer
-- A plugin that colorizes the hex codes in your code

return {
	"brenoprata10/nvim-highlight-colors",
	config = function()
		require("nvim-highlight-colors").setup()
	end,
}
