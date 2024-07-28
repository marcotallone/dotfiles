--┌─────────────────────────────────────────────────────────────────────────┐--
--│                                 VimTeX	  															│--
--└─────────────────────────────────────────────────────────────────────────┘--

return {
	"lervag/vimtex",
	lazy = false,
	tag = "v2.15",
	init = function()
		vim.cmd [[
						filetype plugin indent on
						syntax enable
						]]

		-- Set compiler method to latexmk
		vim.g.vimtex_compiler_method = 'latexmk'

		-- Settings to compile with lualatex
		vim.g.vimtex_compiler_latexmk_engines = {
			_ = '-lualatex'
		}
		vim.g.vimtex_compiler_latexmk = {
			options = {
				'-pdf',              -- Use PDF output
				'-lualatex',         -- Use lualatex engine
				'-synctex=1',        -- Enable synctex
				'-interaction=nonstopmode',
				'-shell-escape'      -- Allow shell escape for external commands
			},
		}

		-- Configure viewers
		vim.g.vimtex_view_method = 'zathura'
		vim.g.vimtex_view_general_viewer = 'okular'
		vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

		-- Disable automatic warning and error window when compiling
		vim.g.vimtex_quickfix_open_on_error = 0
		vim.g.vimtex_quickfix_open_on_warning = 0

		-- Disable Syntax Highlighting by Vimtex
		vim.g.vimtex_syntax_enabled = 0
		vim.g.vimtex_syntax_conceal_disable = 1

	end
}
