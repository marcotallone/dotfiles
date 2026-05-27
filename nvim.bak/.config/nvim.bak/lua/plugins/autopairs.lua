--┌─────────────────────────────────────────────────────────────────────────┐--
--│                                 Autopairs  															│--
--└─────────────────────────────────────────────────────────────────────────┘--
-- Autopairs is a plugin that automatically adds closing pairs for you. It   --
-- works with treesitter to avoid adding pairs in certain treesitter nodes.  --

return {
	--  "windwp/nvim-autopairs",
	--  event = { "InsertEnter" },
	--  dependencies = {
	--    "hrsh7th/nvim-cmp",
	--  },
	--  config = function()
	--    -- import nvim-autopairs
	--    local autopairs = require("nvim-autopairs")

	--    -- configure autopairs
	--    autopairs.setup({
	--      check_ts = true, -- enable treesitter
	--      ts_config = {
	--        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
	--        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
	--        java = false, -- don't check treesitter on java
	--      },
	--    })

	--    -- import nvim-autopairs completion functionality
	--    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

	--    -- import nvim-cmp plugin (completions plugin)
	--    local cmp = require("cmp")

	--		-- check if event field is defined
	--		if cmp.event == nil then
	--			print("Error: event field is not defined in cmp module")
	--			return
	--		end

	--    -- make autopairs and completion work together
	--		---@diagnostic disable-next-line: undefined-field
	--    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	--  end,

	-- return nothing (disabled)
}
