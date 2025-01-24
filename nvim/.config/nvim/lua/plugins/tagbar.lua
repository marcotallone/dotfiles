--┌─────────────────────────────────────────────────────────────────────────┐--
--│                                 Tagbar	  															│--
--└─────────────────────────────────────────────────────────────────────────┘--

return {
	"preservim/tagbar",
	config = function()
		-- Toggle Tagbar map with Code Structure
		vim.api.nvim_set_keymap('n', '<C-A-b>', ':TagbarToggle<CR>', { noremap = true, silent = true })
	end
}
