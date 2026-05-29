# Neovim Configuration Keymap Reference

> [!WARNING]
> This reference might not be always up-to-date. Always double check by running `:WhichKey` in nvim.

## General

| Key          | Mode   | Description                             |
| ------------ | ------ | --------------------------------------- |
| `<C-s>`      | Normal | Save file (shows a notification popup)  |
| `<C-q>`      | Normal | Quit all                                |
| `<C-z>`      | Insert | Undo                    |
| `<C-a>`      | Insert | Redo                    |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+`  | Normal | Increment number        |
| `<leader>-`  | Normal | Decrement number        |

## Window and Tab Management

| Key          | Mode   | Description                      |
| ------------ | ------ | -------------------------------- |
| `<leader>sv` | Normal | Split vertically                 |
| `<leader>sh` | Normal | Split horizontally               |
| `<leader>se` | Normal | Equalize split sizes             |
| `<leader>sx` | Normal | Close current split              |
| `<leader>sm` | Normal | Maximize / restore current split |
| `<leader>to` | Normal | Open new tab                     |
| `<leader>tx` | Normal | Close current tab                |
| `<leader>tp` | Normal | Previous tab                     |
| `<leader>tf` | Normal | Open current buffer in a new tab |
| `<S-Tab>`    | Normal | Next tab                         |

## File Explorer (NvimTree)

| Key          | Mode   | Description                     |
| ------------ | ------ | ------------------------------- |
| `<C-b>`      | Normal | Toggle file explorer            |
| `<leader>ef` | Normal | Toggle explorer on current file |
| `<leader>ec` | Normal | Collapse all directories        |
| `<leader>er` | Normal | Refresh the tree                |

## Fuzzy Finder (Telescope)

| Key          | Mode            | Description                       |
| ------------ | --------------- | --------------------------------- |
| `<C-f>`      | Normal          | Find files                        |
| `<leader>fr` | Normal          | Recent files                      |
| `<leader>fg` | Normal          | Live grep                         |
| `<leader>fc` | Normal          | Grep word under cursor            |
| `<leader>ft` | Normal          | Find TODO comments                |
| `<C-k>`      | Insert (picker) | Previous result                   |
| `<C-j>`      | Insert (picker) | Next result                       |
| `<C-q>`      | Insert (picker) | Send to quickfix and open Trouble |
| `<C-t>`      | Insert (picker) | Open in Trouble                   |

## Treesitter (Incremental Selection)

| Key         | Mode   | Description               |
| ----------- | ------ | ------------------------- |
| `<C-space>` | Normal | Start or expand selection |
| `<BS>`      | Normal | Shrink selection          |

## Sessions

| Key          | Mode   | Description     |
| ------------ | ------ | --------------- |
| `<leader>wr` | Normal | Restore session |
| `<leader>ws` | Normal | Save session    |

## TODO Comments

| Key  | Mode   | Description           |
| ---- | ------ | --------------------- |
| `]t` | Normal | Next TODO comment     |
| `[t` | Normal | Previous TODO comment |

## Trouble

| Key          | Mode   | Description              |
| ------------ | ------ | ------------------------ |
| `<leader>xx` | Normal | Toggle diagnostics panel |
| `<leader>xd` | Normal | Document diagnostics     |
| `<leader>xq` | Normal | Quickfix list            |
| `<leader>xl` | Normal | Location list            |
| `<leader>xt` | Normal | TODO comments            |

## Tagbar

| Key       | Mode   | Description                   |
| --------- | ------ | ----------------------------- |
| `<C-A-b>` | Normal | Toggle code structure sidebar |

## LSP (active when LSP is attached)

| Key          | Mode           | Description                                       |
| ------------ | -------------- | ------------------------------------------------- |
| `gR`         | Normal         | Show references (Telescope)                       |
| `gD`         | Normal         | Go to declaration                                 |
| `gd`         | Normal         | Go to definition (Telescope)                      |
| `gi`         | Normal         | Go to implementations (Telescope)                 |
| `gt`         | Normal         | Go to type definitions (Telescope)                |
| `K`          | Normal         | Hover documentation (hover.nvim, all sources)     |
| `gK`         | Normal         | Enter the hover floating window                   |
| `<C-p>`      | Normal         | Hover: switch to previous source                  |
| `<C-n>`      | Normal         | Hover: switch to next source                      |
| `<leader>ca` | Normal, Visual | Code actions                                      |
| `<leader>rn` | Normal         | Rename symbol                                     |
| `<leader>D`  | Normal         | Buffer diagnostics (Telescope)                    |
| `<leader>d`  | Normal         | Line diagnostics (hover.nvim diagnostic provider) |
| `[d`         | Normal         | Previous diagnostic                               |
| `]d`         | Normal         | Next diagnostic                                   |
| `<leader>rs` | Normal         | Restart LSP                                       |

## Formatting and Linting

| Key          | Mode           | Description              |
| ------------ | -------------- | ------------------------ |
| `<leader>mp` | Normal, Visual | Format file or selection |
| `<leader>ml` | Normal         | Trigger linting          |

## Autocompletion (active in insert mode)

| Key         | Mode   | Description              |
| ----------- | ------ | ------------------------ |
| `<C-k>`     | Insert | Previous completion item |
| `<C-j>`     | Insert | Next completion item     |
| `<C-b>`     | Insert | Scroll docs up           |
| `<C-f>`     | Insert | Scroll docs down         |
| `<C-Space>` | Insert | Open completion menu     |
| `<C-e>`     | Insert | Close completion menu    |
| `<CR>`      | Insert | Confirm completion       |
| `<Tab>`     | Insert | Confirm completion       |
