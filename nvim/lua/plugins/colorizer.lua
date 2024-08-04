--┌─────────────────────────────────────────────────────────────────────────┐--
--│                               Colorizer	  															│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- Colorizer is a plugin that colorizes the hex codes in your code.

-- Tokyonight theme:
return {
	"brenoprata10/nvim-highlight-colors",
	config = function()
		require("nvim-highlight-colors").setup()
	end,
}
