-- Surround
-- Easily add, change, and delete surrounding characters in Neovim

return {
	"tpope/vim-surround",
	version = false, -- no tags available
	event = "VeryLazy", -- utility plugin, lazy load
	dependencies = { "tpope/vim-repeat" }, -- repeat enhances surround's . command
}
