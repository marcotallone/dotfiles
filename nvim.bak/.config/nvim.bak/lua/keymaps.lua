--┌─────────────────────────────────────────────────────────────────────────┐--
--│                                 Keymaps	  															│--
--└─────────────────────────────────────────────────────────────────────────┘--

-- Set leader to space
vim.g.mapleader = " "

-- For conciseness
local keymap = vim.keymap

-- Save
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save" })

-- Exit
keymap.set("n", "<C-q>", ":qa<CR>", { desc = "Exit" })

-- Copy to clipboard
-- vim.api.nvim_set_keymap("v", "<C-c>",
-- '"+y<CR>', { noremap = true, silent = true })
-- keymap.set("n", "<C-c>", '"+y<CR>', { desc = "Copy" })

-- Paste from clipboard
-- vim.api.nvim_set_keymap("n", "<C-p>",
-- '"+p<CR>', { noremap = true, silent = true })
-- keymap.set("n", "<C-p>", '"+p<CR>', { desc = "Paste" })

-- Undo (in insert mode)
vim.api.nvim_set_keymap("i", "<C-z>", "<C-o>u", { noremap = true, silent = true })

-- Redo (in insert mode)
vim.api.nvim_set_keymap("i", "<C-a>", "<C-o><C-r>", { noremap = true, silent = true })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<S-Tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Copilot suggestions
local function SuggestOneCharacter()
	local suggestion = vim.fn["copilot#Accept"]("")
	local bar = vim.fn["copilot#TextQueuedForInsertion"]()
	return bar:sub(1, 1)
end

local function SuggestOneWord()
	local suggestion = vim.fn["copilot#Accept"]("")
	local bar = vim.fn["copilot#TextQueuedForInsertion"]()
	return vim.fn.split(bar, [[[ .]\zs]])[1]
end

keymap.set("i", "<C-l>", SuggestOneCharacter, { expr = true, desc = "Suggest one character" })
keymap.set("i", "<C-A-l>", SuggestOneWord, { expr = true, desc = "Suggest one word" })

-- LaTeX keymaps

-- -- Equation* Environment
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	"<C-e>",
-- 	"\\begin{equation*}<CR><CR>\\end{equation*}<ESC>kA",
-- 	{ noremap = true, silent = true }
-- )

-- -- Example Environment
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	"<C-x>",
-- 	"\\begin{example}{}{}<CR><CR>\\end{example}<ESC>kA",
-- 	{ noremap = true, silent = true }
-- )

-- -- Definition Environment
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	"<C-d>",
-- 	"\\begin{definition}{}{}<CR><CR>\\end{definition}<ESC>kA",
-- 	{ noremap = true, silent = true }
-- )

-- -- Theorem Environment
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	"<C-t>",
-- 	"\\begin{theorem}{}{}<CR><CR>\\end{theorem}<ESC>kA",
-- 	{ noremap = true, silent = true }
-- )

-- -- Warning Environment
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	"<C-f>",
-- 	"\\begin{warning}<CR><CR>\\end{warning}<ESC>kA",
-- 	{ noremap = true, silent = true }
-- )

-- -- Info Environment
-- vim.api.nvim_set_keymap("i", "<C-j>", "\\begin{info}<CR><CR>\\end{info}<ESC>kA", { noremap = true, silent = true })

-- Wrap \begin{} \end{} around word
function latexWrap()
	-- Copy current word into register
	vim.cmd("normal! yiw")

	-- Get the copied word from the register
	local word = vim.fn.getreg('"')

	-- Insert \begin{word} \end{word} tags
	vim.api.nvim_feedkeys(
		"ciw\\begin{"
			.. word
			.. "}"
			.. vim.api.nvim_replace_termcodes("<CR><CR>\\end{" .. word .. "}", true, true, true)
			.. vim.api.nvim_replace_termcodes("<ESC>kA", true, true, true),
		"n",
		true
	)
end
vim.api.nvim_set_keymap("n", "<A-CR>", ":lua latexWrap()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-CR>", ":lua latexWrap()<CR>", { noremap = true, silent = true })

-- LaTeX keymaps (normal mode)
keymap.set("n", "<leader>le", "O\\begin{equation*}<CR><CR>\\end{equation*}<ESC>kA", { desc = "Equation* Environment" })

keymap.set("n", "<leader>lx", "O\\begin{example}<CR><CR>\\end{example}<ESC>kA", { desc = "Example Environment" })

keymap.set(
	"n",
	"<leader>ld",
	"O\\begin{definition}<CR><CR>\\end{definition}<ESC>kA",
	{ desc = "Definition Environment" }
)

keymap.set("n", "<leader>lt", "O\\begin{theorem}<CR><CR>\\end{theorem}<ESC>kA", { desc = "Theorem Environment" })

keymap.set(
	"n",
	"<leader>lp",
	"O\\begin{proposition}<CR><CR>\\end{proposition}<ESC>kA",
	{ desc = "Proposition Environment" }
)

keymap.set("n", "<leader>lw", "O\\begin{warning}<CR><CR>\\end{warning}<ESC>kA", { desc = "Warning Environment" })

keymap.set("n", "<leader>li", "O\\begin{info}<CR><CR>\\end{info}<ESC>kA", { desc = "Info Environment" })

keymap.set("n", "<leader>lb", "O\\begin{blueinfo}<CR><CR>\\end{blueinfo}<ESC>kA", { desc = "Blueinfo Environment" })

keymap.set("n", "<leader>lc", "O\\begin{code}{Pseudocode}<CR><CR>\\end{code}<ESC>kA", { desc = "Code Environment" })

keymap.set("n", "<leader>lo", "O\\begin{code}{cbox}<CR><CR>\\end{cbox}<ESC>kA", { desc = "Box Environment" })
