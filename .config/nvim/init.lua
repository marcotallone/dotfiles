--┌─────────────────────────────────────────────────────────────────────────┐--
--│                             Lazy Nvim Init 															│--
--└─────────────────────────────────────────────────────────────────────────┘--

-- This first snippet check if the lazy loader has its folder already set up.
-- If not, it clones the proper repository to install the lazy loader folder.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Enable termguicolors for true color support (tmux)
vim.o.termguicolors = true

-- This second snippet is the main entry point for the lazy loader.
-- Here we require the necessary modules to set up the nvim configuration.
require("options") -- general nvim settings
require("keymaps") -- general purpose key mappings
require("lazy").setup( -- lazy loader launcher
	{
		{ import = "plugins" }, -- plugins folder
		{ import = "plugins.lsp" }, -- lsp folder
	},
	{
		change_detection = { -- disable changes notifications
			notify = false,
		},
	}
)
