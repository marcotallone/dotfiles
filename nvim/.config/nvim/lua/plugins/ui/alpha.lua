-- Alpha (dashboard)
-- Nvim dashboard screen

return {
	"goolord/alpha-nvim",
	version = false, -- no releases
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set current working dir as header
		local cwd = vim.fn.getcwd()
		dashboard.section.header.val = {
			"󰪺 " .. cwd,
		}

		-- Set menu
		dashboard.section.buttons.val = {
			-- new file:
			dashboard.button("e", "  New File", ":enew<CR>"),
			-- file explorer:
			dashboard.button("b", "  File Explorer", "<cmd>NvimTreeToggle<CR>"),
			-- find file:
			dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
			-- find string:
			dashboard.button("g", "  Live Word", ":Telescope live_grep<CR>"),
			-- copilot
			dashboard.button("c", "  Copilot", ":OpenCopilotWindow<CR>"),
			-- settings:
			dashboard.button("s", "  Settings", ":e ~/.config/nvim/<CR>"),
			-- restore session:
			dashboard.button("r", "󰦛  Restore Session", ":AutoSession restore<CR>"),
			-- quit:
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			callback = function()
				vim.opt_local.foldenable = false
			end,
		})
	end,
}
