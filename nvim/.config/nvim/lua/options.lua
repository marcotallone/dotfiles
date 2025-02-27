--┌─────────────────────────────────────────────────────────────────────────┐--
--│                            General Options															│--
--└─────────────────────────────────────────────────────────────────────────┘--

-- Line numbers
vim.cmd("set number")
vim.cmd("set relativenumber")

-- Tabs and Indentation
vim.cmd("set autoindent")
-- vim.cmd("set smarttab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- vim.cmd("set expandtab")
-- vim.cmd("set backspace=indent,eol,start")

-- Disable auto-commenting new lines
-- (WARNING: These have to be placed ini an autocommand to avoid being
-- overwritten - see:
-- https://www.reddit.com/r/neovim/comments/191l9bb/how_do_i_integrate_set_formatoptionscro_in_lazyvim/)
vim.api.nvim_create_autocmd("BufWinEnter", {
	command = "set formatoptions-=cro",
})

-- Active mouse
vim.cmd("set mouse=a")

-- Set encoding to UTF-8
vim.cmd("set encoding=UTF-8")

-- Remove preview from completion
vim.cmd("set completeopt-=preview")

-- Set ruler at column 80
vim.cmd("set colorcolumn=80")

-- Auto wrap at column 80
vim.cmd("set tw=80")
vim.cmd("set linebreak")

-- Set leader key (" ": space)
vim.g.mapleader = " "

-- Explorer Menu Tree Style
vim.cmd("let g:netrw_liststyle = 3")

-- Search case sensitive/insensitive
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

-- System clipboard as default register
vim.cmd("set clipboard=unnamedplus")

-- Colorscheme options
vim.cmd("set termguicolors")
vim.cmd("set background=dark")

-- Window splitting
vim.cmd("set splitright")
vim.cmd("set splitbelow")
