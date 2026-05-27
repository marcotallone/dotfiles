-- Markdown Renderer
-- Render markdown files with enhanced visuals in Neovim

return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		main = "render-markdown",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			html = { enabled = false },
			latex = { enabled = false },
		},
	},
}
