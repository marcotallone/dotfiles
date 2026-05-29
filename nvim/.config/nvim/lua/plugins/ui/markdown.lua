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
        -- config = function(_, opts)
        --     require("render-markdown").setup(opts)
        --     -- Disable render-markdown in floating windows (e.g. LSP hover)
        --     vim.api.nvim_create_autocmd("FileType", {
        --         pattern = "markdown",
        --         callback = function()
        --             if vim.api.nvim_win_get_config(0).relative ~= "" then
        --                 require("render-markdown").disable()
        --             end
        --         end,
        --     })
        -- end,
    }
}