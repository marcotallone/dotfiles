-- ┌────────────────────────────────────────────────────────────────────────┐ --
-- │ 󰀵 Lazy Nvim Init                                                       │ --
-- └────────────────────────────────────────────────────────────────────────┘ --

-- This first snippet check if the lazy loader has its folder already set up.
-- If not, it clones the proper repository to install the lazy loader folder.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- This second snippet is the main entry point for the lazy loader.
-- Here we require the necessary modules to set up the nvim configuration.
require("core.options") -- general nvim options
require("core.keymaps") -- general nvim keymaps
require("lazy").setup( -- lazy loader launcher
	{
		spec = {
			-- { import = "plugins" }, -- plugins folder
			{ import = "plugins.lsp" }, -- lsp plugins
            { import = "plugins.ui" }, -- ui / aestethic plugins
            { import = "plugins.editor" }, -- editor / functionalities plugins
		},
        defaults = {
          lazy = true,    -- all plugins lazy by default; each spec overrides as needed
          version = "*",  -- prefer latest semver tag; plugins without tags auto-fallback to branch
        },
		checker = {
			enabled = true,
			notify = false,
		},
		change_detection = { -- disable changes notifications
			notify = false,
		},
	}
)
