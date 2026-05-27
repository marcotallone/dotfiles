-- Bufferline
-- Tab line showing open buffers as tabs on top

return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	lazy = false, -- tabline must render on startup
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
		},
	},
}
