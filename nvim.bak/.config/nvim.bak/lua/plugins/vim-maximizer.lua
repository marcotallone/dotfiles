--┌─────────────────────────────────────────────────────────────────────────┐--
--│                           Window Maximizer															│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- To maximize window on splits (toggle with <leader>sm)										 --

return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>sm",
			"<cmd>MaximizerToggle<CR>",
			desc = "Maximize/minimize a split" },
  },
}
