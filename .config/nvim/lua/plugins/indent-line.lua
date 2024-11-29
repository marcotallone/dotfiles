--┌─────────────────────────────────────────────────────────────────────────┐--
--│                                Indent Line  														│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- Indentation line to better see the scope of the code											 --

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = { char = "┊" },
		-- indent = { char = "│" },
	},

	-- Background shade indentation highlight
	-- config = function()
	-- 	local highlight = {
	-- 		"CursorColumn",
	-- 		"Whitespace",
	-- 	}

	-- 	require("ibl").setup {
	-- 		indent = { highlight = highlight, char = "" },
	-- 		whitespace = {
	-- 			highlight = highlight,
	-- 			remove_blankline_trail = false,
	-- 		},
	-- 		scope = { enabled = false },
	-- 	}

	-- end,

}
