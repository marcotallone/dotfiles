-- Tagbar
-- Displays code structure in a sidebar using ctags

return {
	"preservim/tagbar",
	version = false, -- no tags available
	event = "VeryLazy",
	keys = {
		{ "<C-A-b>", "<cmd>TagbarToggle<CR>", desc = "Toggle code structure sidebar" },
	},
}
