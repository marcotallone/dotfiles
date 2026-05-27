-- ┌────────────────────────────────────────────────────────────────────────┐ --
-- │   General Nvim Options                                                │ --
-- └────────────────────────────────────────────────────────────────────────┘ --
-- │ version: fedora
-- │ author: Marco Tallone
-- │ date: May 2026
--
-- For more information, see :help <option-name>

-- Line numbers
vim.cmd("set number") -- show line numbers
vim.cmd("set relativenumber") -- show relative line numbers

-- Tabs and Indentation
vim.cmd("set tabstop=4") -- number of visual spaces per TAB
vim.cmd("set softtabstop=4") -- number of spaces in tab when editing
vim.cmd("set shiftwidth=4") -- number of spaces to use for autoindent
vim.cmd("set expandtab") -- use spaces instead of tabs
vim.cmd("set autoindent") -- copy current line indent when starting a new line

-- Backspace
vim.cmd("set backspace=indent,eol,start") -- allow backspace on indent, end of line or start of insertion

-- Disable auto-commenting new lines
-- WARNING: These have to be placed in a autocommand
--          to avoid being overwritten. See:
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
vim.cmd("set tw=80") -- textwidth
vim.cmd("set linebreak") -- wrap lines at convenient points

-- Set leader key (" ": space)
vim.g.mapleader = " "

-- Explorer Menu Tree Style
vim.cmd("let g:netrw_liststyle = 3")

-- Search case sensitive/insensitive
vim.cmd("set ignorecase") -- ignore case in search patterns if all lowercase
vim.cmd("set smartcase") -- when 'MiXeD cAsE' is used, becomes case sensitive

-- System clipboard as default register
vim.cmd("set clipboard=unnamedplus") -- use system clipboard as default register

-- Colorscheme options
-- vim.o.termguicolors = true -- enable termguicolors for true color support (tmux)
vim.cmd("set termguicolors") -- enable termguicolors for true color support (tmux)
vim.cmd("set background=dark") -- themes will use dark background
vim.cmd("set signcolumn=yes") -- show sign column to avoid text shifting in

-- Window splitting
vim.cmd("set splitright") -- follow window splitting to the right
vim.cmd("set splitbelow") -- follow window splitting to the bottom

-- Options for auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
