# Neovim Configuration Documentation

> Fedora version

Documentation for my personal Neovim setup managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

Plugins are split into 3 groups: [editor](./lua/plugins/editor/), [lsp](./lua/plugins/lsp/), and [ui](./lua/plugins/ui/).

Version pinning and lazy loading are applied throughout to keep the configuration stable and startup time low.

---

## Table of Contents

1. [Requirements](#requirements)
2. [Directory Structure](#directory-structure)
3. [Installation](#installation)
4. [Entry Point](#entry-point)
5. [Core Settings](#core-settings)
6. [Plugin Architecture](#plugin-architecture)
7. [UI Plugins](#ui-plugins)
8. [Editor Plugins](#editor-plugins)
9. [LSP Plugins](#lsp-plugins)
10. [Keymap Reference](#complete-keymap-reference)
11. [Maintenance](#maintenance)

---

## Requirements

| Requirement                               | Purpose                                                                   |
| ----------------------------------------- | ------------------------------------------------------------------------- |
| Neovim >= 0.12                            | Required for `vim.uv`, `vim.lsp.config()`, and `vim.lsp.enable()`         |
| Git                                       | Used by lazy.nvim to clone and update plugins                             |
| A [Nerd Font](https://www.nerdfonts.com/) | Required for icons in the dashboard, statusline, file tree, and LSP signs |
| `make`                                    | Required to build `telescope-fzf-native` for fast fuzzy sorting           |
| `ripgrep` (`rg`)                          | Required for Telescope's `live_grep` and `grep_string` pickers            |
| `ctags`                                   | Required for Tagbar's code structure sidebar                              |

> [!NOTE]
> Always check additional requirements with `: checkhealth` in nvim.

---

## Directory Structure

```text
nvim/
├── init.lua                        Entry point, bootstrap and lazy.nvim setup
├── lazy-lock.json                  Plugin version lockfile (commit hashes)
└── lua/
    ├── core/
    │   ├── options.lua             General Neovim options
    │   └── keymaps.lua             General Neovim keymaps
    └── plugins/
        ├── ui/                     Visual and interface plugins
        │   ├── theme.lua
        │   ├── alpha.lua
        │   ├── bufferline.lua
        │   ├── colorizer.lua
        │   ├── dressing.lua
        │   ├── indent-line.lua
        │   ├── lualine.lua
        │   └── markdown.lua
        ├── editor/                 Editor functionality plugins
        │   ├── autopairs.lua
        │   ├── autosession.lua
        │   ├── multiple-cursors.lua
        │   ├── plenary.lua
        │   ├── tagbar.lua
        │   ├── telescope.lua
        │   ├── todo-comments.lua
        │   ├── tpope-commentary.lua
        │   ├── tpope-repeat.lua
        │   ├── tpope-surround.lua
        │   ├── tree.lua
        │   ├── treesitter.lua
        │   ├── trouble.lua
        │   ├── vim-maximizer.lua
        │   ├── vim-tmux-navigator.lua
        │   ├── vimtex.lua          (disabled, all content commented out)
        │   └── which-key.lua
        └── lsp/                    Language server and completion plugins
            ├── cmp.lua
            ├── formatting.lua
            ├── linting.lua
            ├── lsp-config.lua
            └── mason.lua
```

---

## Installation

1. Back up any existing Neovim configuration:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone or symlink this configuration into `~/.config/nvim`.

   > [!NOTE]
   > If you cloned the [dotfiles repository](https://github.com/marcotallone/dotfiles), simply run `stow nvim` from dotfiles root folder after step 1.

3. Open Neovim. On first launch, lazy.nvim bootstraps itself automatically, then installs all plugins.

4. After installation finishes, restart Neovim. Run `:Mason` or one of Mason commands to verify that LSP servers and tools listed under `ensure_installed` are installed.
   Useful Mason commands:

- `:MasonToolsInstall` - only installs tools that are missing or at the incorrect version

- `:MasonToolsInstallSync` - execute `:MasonToolsInstall` in blocking manner. It's useful in Neovim headless mode.

- `:MasonToolsUpdate` - install missing tools and update already installed tools

- `:MasonToolsUpdateSync` - execute `:MasonToolsUpdate` in blocking manner. It's useful in Neovim headless mode.

- `:MasonToolsClean` - remove installed packages that are not listed in `ensure_installed`

---

## Entry Point

**File:** [`init.lua`](./init.lua)

`init.lua` is the root entry point. It performs three steps in order:

**1. Bootstrap lazy.nvim.**
It checks for lazy.nvim at `~/.local/share/nvim/lazy/lazy.nvim`. If not found, it clones the repository from GitHub using `--branch=stable`, which pins lazy.nvim itself to its latest stable release. `vim.uv.fs_stat` is used instead of the older `vim.loop.fs_stat` (deprecated since Neovim 0.10).

**2. Load core modules.**
It calls `require("core.options")` and `require("core.keymaps")` to apply Neovim settings and base keymaps before any plugin loads.

**3. Start lazy.nvim.**
It calls `require("lazy").setup(...)` with three plugin import groups:

```lua
spec = {
    { import = "plugins.lsp" },
    { import = "plugins.ui" },
    { import = "plugins.editor" },
},
```

Each entry scans the corresponding subdirectory and loads every `.lua` file in it as a plugin spec. Adding a new plugin is as simple as creating a new file in the appropriate subfolder.

Two global defaults apply to every plugin unless overridden:

```lua
defaults = {
    lazy = true,   -- every plugin is lazy-loaded unless explicitly set otherwise
    version = "*", -- prefer the latest semver-tagged release
},
```

> [!NOTE]
> To disable lazy loading for a specific plugin specify either:
>
> ```lua
> lazy = false,  -- load at startup
> ```
>
> Or:
>
> ```lua
> event = "VeryLazy", -- or other event trigger as needed
> ```
>
> See the [Lazy Loading Strategy](#lazy-loading-strategy) section below for more on event triggers.

> [!NOTE]
> To disable pulling latest tag releases for a specific plugin specify:
>
> ```lua
> version = false,  -- always use the latest commit on the default branch
> ```
>
> Or a specific branch with:
>
> ```lua
> version = false,
> branch = "main",  -- use the latest commit on the specified branch
> ```
>
> See the [Version Pinning Strategy](#version-pinning-strategy) section below for more on version pinning.

---

## Core Settings

### Options

**File:** [`lua/core/options.lua`](./lua/core/options.lua)

| Option                                   | Value         | Effect                                                                                       |
| ---------------------------------------- | ------------- | -------------------------------------------------------------------------------------------- |
| `number` + `relativenumber`              | on            | Absolute number on current line, relative numbers on all others                              |
| `tabstop` / `softtabstop` / `shiftwidth` | 4             | All indentation uses 4-space width                                                           |
| `expandtab`                              | on            | Tab key inserts spaces, not a tab character                                                  |
| `clipboard`                              | `unnamedplus` | System clipboard is the default register; `y`, `p`, etc. work with the OS clipboard directly |
| `colorcolumn`                            | 80            | Vertical ruler drawn at column 80                                                            |
| `tw` (textwidth)                         | 80            | Lines wrap automatically at column 80                                                        |
| `ignorecase` + `smartcase`               | on            | Search is case-insensitive unless uppercase letters are used in the pattern                  |
| `splitright` + `splitbelow`              | on            | Vertical splits open to the right, horizontal splits open below                              |
| `signcolumn`                             | `yes`         | Sign column is always visible, preventing layout shifts when diagnostics appear              |
| `termguicolors`                          | on            | Full 24-bit color support                                                                    |
| `mouse`                                  | `a`           | Mouse is enabled in all modes                                                                |
| `sessionoptions`                         | (full list)   | Defines what `auto-session` saves and restores per session                                   |

Auto-commenting on new lines is disabled by removing `c`, `r`, and `o` from `formatoptions` inside a `BufWinEnter` autocmd. This must be done in an autocmd because filetype plugins reset `formatoptions` after each buffer is opened.

### Keymaps

**File:** [`lua/core/keymaps.lua`](./lua/core/keymaps.lua)

The leader key is `Space` (`vim.g.mapleader = " "`).

| Key          | Mode   | Description                      |
| ------------ | ------ | -------------------------------- |
| `<C-s>`      | Normal | Save file                        |
| `<C-q>`      | Normal | Quit all                         |
| `<C-z>`      | Insert | Undo                             |
| `<C-a>`      | Insert | Redo                             |
| `<leader>nh` | Normal | Clear search highlights          |
| `<leader>+`  | Normal | Increment number under cursor    |
| `<leader>-`  | Normal | Decrement number under cursor    |
| `<leader>sv` | Normal | Split window vertically          |
| `<leader>sh` | Normal | Split window horizontally        |
| `<leader>se` | Normal | Equalize split sizes             |
| `<leader>sx` | Normal | Close current split              |
| `<leader>to` | Normal | Open new tab                     |
| `<leader>tx` | Normal | Close current tab                |
| `<leader>tp` | Normal | Go to previous tab               |
| `<leader>tf` | Normal | Open current buffer in a new tab |
| `<S-Tab>`    | Normal | Go to next tab                   |

---

## Plugin Architecture

### Version Pinning Strategy

The global default `version = "*"` instructs lazy.nvim to install the latest semver-tagged release for every plugin. Individual plugins override this when needed:

- **`version = false`** is used for plugins that have no proper semver releases, that have releases that are too old with respect to the most recent commit or that use non-standard tag formats (for example, `nvim-tree-vX.Y.Z` instead of `vX.Y.Z`). This tells lazy.nvim to use the latest commit on the default branch.
- **`version = "^2.0"`** pins to the latest release within the `2.x` major version, used for Mason to avoid breaking API changes from a future v3.
- **`branch = "main"`** alongside `version = false` is used for [`nvim-treesitter`](./lua/plugins/editor/treesitter.lua), which requires an explicit branch because its `main` and `master` branches have entirely different APIs.

**The [`lazy-lock.json`](./lazy-lock.json) file** records the exact branch and commit hash for every installed plugin. This file should be committed to version control. It is the basis for `:Lazy restore`, which reverts all plugins to the exact versions recorded in the lockfile.

### Lazy Loading Strategy

The global `lazy = true` default means no plugin loads at startup unless it explicitly overrides this. Each plugin specifies one or more triggers:

| Trigger                                  | Used for                                                                                                |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `lazy = false`                           | Plugins that must be present at startup: theme, statusline, bufferline, session manager, tmux navigator |
| `event = "VimEnter"`                     | Dashboard (alpha)                                                                                       |
| `event = "VeryLazy"`                     | Utility plugins needed shortly after startup but not immediately                                        |
| `event = { "BufReadPre", "BufNewFile" }` | Plugins that act on file content: LSP, treesitter, linting, formatting, indent lines                    |
| `event = "InsertEnter"`                  | Insert-mode plugins: autocompletion, autopairs                                                          |
| `cmd = "..."`                            | Plugins loaded only when a specific command is run: Telescope, NvimTree, Trouble                        |
| `keys = { ... }`                         | Plugins loaded only when a specific keymap is pressed: vim-maximizer, tagbar                            |
| `ft = { "..." }`                         | Filetype-specific plugins: markdown renderer                                                            |

---

## UI Plugins

### Theme

> **File:** [`lua/plugins/ui/theme.lua`](./lua/plugins/ui/theme.lua)\
> **Plugin:** [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

Sets the colorscheme to `tokyonight-night`, the darkest variant of the four available (`storm`, `moon`, `night`, `day`). Uses `lazy = false` and `priority = 1000` to guarantee this plugin loads before everything else.

### Dashboard

> **File:** [`lua/plugins/ui/alpha.lua`](./lua/plugins/ui/alpha.lua)\
> **Plugin:** [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)

Shows a startup dashboard when Neovim is opened without a file. The header displays the current working directory. The menu offers quick shortcuts:

| Key | Action                       |
| --- | ---------------------------- |
| `e` | New empty file               |
| `b` | Open file explorer           |
| `f` | Find file with Telescope     |
| `g` | Live grep with Telescope     |
| `s` | Open Neovim config directory |
| `r` | Restore last session         |
| `q` | Quit Neovim                  |

Triggered by `event = "VimEnter"`. Folding is disabled on the alpha buffer to prevent visual artifacts.

### Bufferline (Tab Bar)

> **File:** [`lua/plugins/ui/bufferline.lua`](./lua/plugins/ui/bufferline.lua)\
> **Plugin:** [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)

Renders open tabs as styled tabs at the top of the screen. Configured with `mode = "tabs"` (shows Neovim tabs, not individual buffers) and `separator_style = "slant"`. Uses `lazy = false` so the tab bar is visible from startup.

### Statusline

> **File:** [`lua/plugins/ui/lualine.lua`](./lua/plugins/ui/lualine.lua)\
> **Plugin:** [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

Renders a statusline at the bottom of the screen using the `tokyonight` theme. The right section shows a pending plugin update count sourced from lazy.nvim, file encoding, file format, and filetype. Uses `lazy = false` and `version = false` (no semver releases).

### Color Highlighter

> **File:** [`lua/plugins/ui/colorizer.lua`](./lua/plugins/ui/colorizer.lua)\
> **Plugin:** [brenoprata10/nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)

Highlights color codes inline by rendering the actual color as a background swatch next to the code. Supports hex, RGB, CSS names, and more. Works automatically on any file. Uses `version = false` because the plugin uses tag names without the standard `v` prefix.

### UI Input/Select (Dressing)

> **File:** [`lua/plugins/ui/dressing.lua`](./lua/plugins/ui/dressing.lua)\
> **Plugin:** [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)

Replaces Neovim's default `vim.ui.input()` and `vim.ui.select()` with styled floating windows. This improves the appearance of rename prompts, code action menus, and similar dialogs. No setup required.

### Indent Lines

> **File:** [`lua/plugins/ui/indent-line.lua`](./lua/plugins/ui/indent-line.lua)\
> **Plugin:** [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

Draws a subtle vertical guide line at each indentation level. Uses the `┊` character. The spec uses `main = "ibl"` because the v3 API renamed the module from `indent_blankline` to `ibl`.

### Markdown Renderer

> **File:** [`lua/plugins/ui/markdown.lua`](./lua/plugins/ui/markdown.lua)\
> **Plugin:** [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

Renders Markdown files with visual enhancements: styled headings, rendered checkboxes, code block backgrounds, and table borders. HTML and LaTeX rendering are disabled. Loads only for Markdown files (`ft = { "markdown" }`).

---

## Editor Plugins

### File Explorer

> **File:** [`lua/plugins/editor/tree.lua`](./lua/plugins/editor/tree.lua)\
> **Plugin:** [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

A sidebar file explorer. The `init` function disables Neovim's built-in `netrw` before anything loads, which is required for NvimTree to take over file browsing correctly. This must be done in `init` (not `config`) because `netrw` loads very early.

Key settings: sidebar width is 30 columns, relative line numbers are shown, files are sorted by extension, dotfiles are visible, `.DS_Store` files are hidden, and git-ignored files are shown.

Uses `version = false` because NvimTree tags use the format `nvim-tree-vX.Y.Z`, which does not match standard semver.

| Key          | Description                                 |
| ------------ | ------------------------------------------- |
| `<C-b>`      | Toggle file explorer                        |
| `<leader>ef` | Toggle explorer focused on the current file |
| `<leader>ec` | Collapse all directories                    |
| `<leader>er` | Refresh the tree                            |

### Fuzzy Finder (Telescope)

> **File:** [`lua/plugins/editor/telescope.lua`](./lua/plugins/editor/telescope.lua)\
> **Plugin:** [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

A fuzzy finder for files, text search, LSP symbols, diagnostics, and more. The `telescope-fzf-native` extension provides fast native fuzzy sorting (requires `make` to compile). `ripgrep` is required for `live_grep`.

**Known bugs and workarounds applied in this config:**

1. **`mouse_click` error (telescope v0.2.x):**
   Telescope's default key table references `actions.mouse_click` and `actions.double_mouse_click` at module load time, but these functions are not defined in `actions/init.lua`. This causes an error that corrupts the Lua module cache and breaks all Telescope commands.
   The fix is to inject stub functions before the rest of Telescope loads:

   ```lua
   local actions = require("telescope.actions")
   actions.mouse_click = function() return "" end
   actions.double_mouse_click = function() return "" end
   ```

   This must happen at the top of the `config` function, before any other `require("telescope...")` call.

| Key          | Mode            | Description                                           |
| ------------ | --------------- | ----------------------------------------------------- |
| `<C-f>`      | Normal          | Find files in current directory                       |
| `<leader>fr` | Normal          | Find recently opened files                            |
| `<leader>fg` | Normal          | Live grep (search text across all files)              |
| `<leader>fc` | Normal          | Grep for word under cursor                            |
| `<leader>ft` | Normal          | Find TODO comments                                    |
| `<C-k>`      | Insert (picker) | Move to previous result                               |
| `<C-j>`      | Insert (picker) | Move to next result                                   |
| `<C-q>`      | Insert (picker) | Send selected items to quickfix list and open Trouble |
| `<C-t>`      | Insert (picker) | Open selected item in Trouble                         |

### Syntax Highlighting (Treesitter)

> **File:** [`lua/plugins/editor/treesitter.lua`](./lua/plugins/editor/treesitter.lua)\
> **Plugins:**
>
> - [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
> - [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)
> - [MeanderingProgrammer/treesitter-modules.nvim](https://github.com/MeanderingProgrammer/treesitter-modules.nvim)

> [!WARNING]
> `nvim-treesitter` was archived on April 3, 2026 and is now permanently read-only. Both the `main` and `master` branches are frozen. The plugin continues to work, but will not receive further updates or new parser support.

This config uses the `main` branch, which introduced a new API in 2025. The key changes from the old API are:

- Parsers are installed by calling `require("nvim-treesitter").install{ ... }` directly rather than using `ensure_installed` in a setup table.
- Highlighting and indentation are enabled per buffer using a `FileType` autocmd, not a global `configs.setup()` call.
- Features removed from core require separate plugins. Incremental selection uses [treesitter-modules.nvim](https://github.com/MeanderingProgrammer/treesitter-modules.nvim) and auto-tagging uses [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) as standalone plugins.

**Installed parsers:** `python`, `cpp`, `cmake`, `dockerfile`, `bash`, `fortran`, `markdown`, `latex`, `lua`, `vim`, `vimdoc`, `c`, `query`. The last five should always be installed as they are needed by Neovim and lazy.nvim itself.

**Incremental selection (via treesitter-modules.nvim):**

| Key         | Description                                       |
| ----------- | ------------------------------------------------- |
| `<C-space>` | Start selection or expand to the next syntax node |
| `<BS>`      | Shrink selection to the previous syntax node      |

A full fallback configuration for the `master` branch (old API) is preserved as a comment at the bottom of the file. To switch, comment out the active `return {}` block and uncomment the fallback.

### Session Management

> **File:** [`lua/plugins/editor/autosession.lua`](./lua/plugins/editor/autosession.lua)\
> **Plugin:** [rmagatti/auto-session](https://github.com/rmagatti/auto-session)

Saves and restores Neovim sessions per working directory. Automatic session restore on startup is disabled (`auto_restore = false`) so sessions are only loaded on explicit request. Sessions are never saved for common top-level directories (`~/`, `~/Dev/`, `~/Downloads`, `~/Documents`, `~/Desktop/`).

Uses `lazy = false` because session management must run before any buffers open.

| Key          | Description                               |
| ------------ | ----------------------------------------- |
| `<leader>wr` | Restore session for the current directory |
| `<leader>ws` | Save session for the current directory    |

### Autopairs

> **File:** [`lua/plugins/editor/autopairs.lua`](./lua/plugins/editor/autopairs.lua)\
> **Plugin:** [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)

Automatically inserts closing brackets, quotes, and other pairs as you type. Treesitter integration (`check_ts = true`) prevents pairs from being inserted inside string and template nodes where they would be incorrect. Also integrates with nvim-cmp so that confirming a completion does not double-insert a closing pair.

Uses `version = false` because the plugin uses tag names without the standard `v` prefix. Triggered by `event = "InsertEnter"`.

### Multiple Cursors

> **File:** [`lua/plugins/editor/multiple-cursors.lua`](./lua/plugins/editor/multiple-cursors.lua)\
> **Plugin:** [mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi)

Provides multiple-cursor editing. The default bindings use `<C-n>` to select the next occurrence of the word under the cursor, building up a multi-cursor selection. Full documentation is available in the plugin's own help file (`:help vm-introduction`).

Uses `version = false` (no releases) and `event = "VeryLazy"`.

### TODO Comments

> **File:** [`lua/plugins/editor/todo-comments.lua`](./lua/plugins/editor/todo-comments.lua)\
> **Plugin:** [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

Highlights and navigates special comment tags: `TODO`, `FIXME`, `NOTE`, `HACK`, `WARN`, `PERF`, and others. Works with Telescope (`<leader>ft`) and Trouble (`<leader>xt`) to list all tagged comments in the project.

| Key  | Description                   |
| ---- | ----------------------------- |
| `]t` | Jump to next TODO comment     |
| `[t` | Jump to previous TODO comment |

### Trouble (Diagnostics List)

> **File:** [`lua/plugins/editor/trouble.lua`](./lua/plugins/editor/trouble.lua)\
> **Plugin:** [folke/trouble.nvim](https://github.com/folke/trouble.nvim)

Displays diagnostics, quickfix results, location lists, and TODO comments in a structured panel. Also used as the target for Telescope results (`<C-t>` and `<C-q>` inside a Telescope picker).

| Key          | Description               |
| ------------ | ------------------------- |
| `<leader>xx` | Toggle diagnostics panel  |
| `<leader>xd` | Show document diagnostics |
| `<leader>xq` | Show quickfix list        |
| `<leader>xl` | Show location list        |
| `<leader>xt` | Show TODO comments        |

### Which Key

> **File:** [`lua/plugins/editor/which-key.lua`](./lua/plugins/editor/which-key.lua)\
> **Plugin:** [folke/which-key.nvim](https://github.com/folke/which-key.nvim)

After a brief delay (500ms), shows a popup listing all available keymaps that start with the keys already pressed. Useful for discovering bindings. The timeout is set in `init` rather than `config` because `timeoutlen` must be set before the plugin loads.

### Tagbar

> **File:** [`lua/plugins/editor/tagbar.lua`](./lua/plugins/editor/tagbar.lua)\
> **Plugin:** [preservim/tagbar](https://github.com/preservim/tagbar)

Displays a sidebar listing the symbols (functions, classes, variables, etc.) in the current file, generated using `ctags`. Requires `ctags` to be installed on the system.

| Key       | Description           |
| --------- | --------------------- |
| `<C-A-b>` | Toggle tagbar sidebar |

### Window Maximizer

> **File:** [`lua/plugins/editor/vim-maximizer.lua`](./lua/plugins/editor/vim-maximizer.lua)\
> **Plugin:** [szw/vim-maximizer](https://github.com/szw/vim-maximizer)

Toggles the current split window between its normal size and a full-screen maximized state.

| Key          | Description                       |
| ------------ | --------------------------------- |
| `<leader>sm` | Maximize or restore current split |

### Tmux Navigator

> **File:** [`lua/plugins/editor/vim-tmux-navigator.lua`](./lua/plugins/editor/vim-tmux-navigator.lua)\
> **Plugin:** [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

Allows seamless navigation between Neovim splits and tmux panes using `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`. No extra configuration is needed in Neovim, but the tmux configuration must also be set up. Uses `lazy = false` so the navigation bindings are active from startup.

### Commentary

> **File:** [`lua/plugins/editor/tpope-commentary.lua`](./lua/plugins/editor/tpope-commentary.lua)\
> **Plugin:** [tpope/vim-commentary](https://github.com/tpope/vim-commentary)

Provides `gc` to toggle comments on lines or motions. For example, `gcc` comments the current line, `gc3j` comments three lines down, and `gcap` comments the current paragraph. Works correctly for every filetype based on the appropriate comment syntax.

### Surround

> **File:** [`lua/plugins/editor/tpope-surround.lua`](./lua/plugins/editor/tpope-surround.lua)\
> **Plugin:** [tpope/vim-surround](https://github.com/tpope/vim-surround)

Adds operations to add, change, and delete surrounding characters (brackets, quotes, tags, etc.). Example operations: `ysiw"` wraps the word under the cursor in double quotes, `cs"'` changes surrounding double quotes to single quotes, `ds"` removes surrounding double quotes. Depends on `vim-repeat` so that surround operations can be repeated with `.`.

### Repeat

> **File:** [`lua/plugins/editor/tpope-repeat.lua`](./lua/plugins/editor/tpope-repeat.lua)\
> **Plugin:** [tpope/vim-repeat](https://github.com/tpope/vim-repeat)

Extends the `.` repeat command to work with plugin operations that would otherwise not be repeatable. Used as a dependency by `vim-surround` and can be used by other plugins that support it.

### Plenary

> **File:** [`lua/plugins/editor/plenary.lua`](./lua/plugins/editor/plenary.lua)\
> **Plugin:** [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

A utility library providing common Lua functions used by many plugins (Telescope, auto-session, todo-comments, and others). Pre-installed with `lazy = true` so it is available immediately when any plugin requires it, avoiding a deferred load on first use.

### VimTeX (Disabled)

> **File:** [`lua/plugins/editor/vimtex.lua`](./lua/plugins/editor/vimtex.lua)\
> **Plugin:** [lervag/vimtex](https://github.com/lervag/vimtex)

Full LaTeX support for Neovim. The entire plugin spec is commented out. To re-enable it, uncomment the file contents. The configuration targets `lualatex` with `latexmk` as the compiler. See the file for full details.

---

## LSP Plugins

### Mason (Package Manager)

> **File:** [`lua/plugins/lsp/mason.lua`](./lua/plugins/lsp/mason.lua)\
> **Plugins:**

- [williamboman/mason.nvim](https://github.com/mason-org/mason.nvim)
- [williamboman/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)

Mason is the package manager for LSP servers, linters, and formatters. It downloads and manages these tools independently of the system package manager.

> [!WARNING]
> The `mason.nvim` repository moved from the `williamboman/` GitHub organization to `mason-org/`. The old URL still redirects, but a future update should change the spec to `"mason-org/mason.nvim"`.

Uses `version = "^2.0"` to pin to Mason v2 and avoid any breaking changes from a future v3.

**LSP servers installed by mason-lspconfig:**
`lua_ls`, `bashls`, `clangd`, `cmake`, `pyright`, `dockerls`, `fortls`, `marksman`, `texlab`, `ltex`, `emmet_ls`

**Linters and formatters installed by mason-tool-installer:**
`stylua`, `pylint`, `eslint_d`, `markdownlint`, `chktex`

Open the Mason UI with `:Mason` to see installed packages and install additional ones interactively.

### LSP Configuration

> **File:** [`lua/plugins/lsp/lsp-config.lua`](./lua/plugins/lsp/lsp-config.lua)\
> **Plugin:** [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

Configures the communication between Neovim and LSP servers. Uses the Neovim 0.11+ native API (`vim.lsp.config()` and `vim.lsp.enable()`) rather than the older lspconfig `setup()` pattern.

**How it works:**

1. Capabilities from `nvim-cmp` are registered globally with `vim.lsp.config("*", { capabilities = ... })` so every server gets completion support without repeating the same line for each one.
2. Most servers are enabled with a single `vim.lsp.enable({ ... })` call.
3. Servers that need extra settings (for example, `pyright`, `lua_ls`, `ltex`) are configured with `vim.lsp.config("server_name", { ... })` before being enabled.

All LSP keymaps are registered inside a `LspAttach` autocmd so they are only active in buffers where an LSP server is connected.

**Active LSP servers:** `bashls`, `clangd`, `cmake`, `dockerls`, `fortls`, `marksman`, `autotools_ls`, `texlab`, `emmet_ls`, `html`, `lua_ls`, `ltex`, `pyright`

**Special server configurations:**

- `ltex`: restricted to `tex` filetypes only (removed `txt` to avoid false positives in plain text files)
- `pyright`: set with `typeCheckingMode = "basic"` and `pythonPath = "/usr/bin/python"`
- `lua_ls`: configured to recognize `vim` as a known global, and the Neovim runtime and config paths are added to the workspace library

**LSP keymaps** (active only when LSP is attached to the buffer):

| Key          | Description                                                |
| ------------ | ---------------------------------------------------------- |
| `gR`         | Show all references (in Telescope)                         |
| `gD`         | Go to declaration                                          |
| `gd`         | Go to definition (in Telescope)                            |
| `gi`         | Go to implementations (in Telescope)                       |
| `gt`         | Go to type definitions (in Telescope)                      |
| `<leader>ca` | Show available code actions                                |
| `<leader>rn` | Rename symbol                                              |
| `<leader>D`  | Show all diagnostics for the current buffer (in Telescope) |
| `<leader>d`  | Show diagnostics for the current line                      |
| `[d`         | Go to previous diagnostic                                  |
| `]d`         | Go to next diagnostic                                      |
| `K`          | Show hover documentation                                   |
| `<leader>rs` | Restart the LSP server                                     |

### Autocompletion (nvim-cmp)

> **File:** [`lua/plugins/lsp/cmp.lua`](./lua/plugins/lsp/cmp.lua)\
> **Plugins:**
>
> - [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
> - [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) (version `^2.0`)
> - [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
> - [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim)

Provides the completion menu, powered by LSP suggestions, buffer text, file paths, and snippets. LuaSnip is the snippet engine. `friendly-snippets` provides a library of pre-built snippets for many languages. `lspkind` adds VS Code-style icons to completion items.

LuaSnip is pinned to `version = "^2.0"` because its v1 and v2 APIs are not compatible.

Triggered by `event = "InsertEnter"`.

**Completion sources** (in priority order): LSP, LuaSnip snippets, buffer text, file paths.

| Key         | Mode   | Description                                               |
| ----------- | ------ | --------------------------------------------------------- |
| `<C-k>`     | Insert | Select previous completion item                           |
| `<C-j>`     | Insert | Select next completion item                               |
| `<C-b>`     | Insert | Scroll documentation window up                            |
| `<C-f>`     | Insert | Scroll documentation window down                          |
| `<C-Space>` | Insert | Trigger completion menu                                   |
| `<C-e>`     | Insert | Close completion menu                                     |
| `<CR>`      | Insert | Confirm selected completion (only if explicitly selected) |

### Formatting

> **File:** [`lua/plugins/lsp/formatting.lua`](./lua/plugins/lsp/formatting.lua)\
> **Plugin:** [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)

Runs code formatters on save and on demand. Format-on-save uses `lsp_fallback = true`, so if no configured formatter applies to the current filetype, the LSP server's formatting capability is used instead.

**Active formatters** (others are commented out but available to enable):

- `lua`: `stylua`
- `markdown`: `markdownlint`

To enable a formatter for another filetype, uncomment the relevant line in `formatters_by_ft`.

| Key          | Mode           | Description                           |
| ------------ | -------------- | ------------------------------------- |
| `<leader>mp` | Normal, Visual | Format current file or selected range |

### Linting

> **File:** [`lua/plugins/lsp/linting.lua`](./lua/plugins/lsp/linting.lua)\
> **Plugin:** [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)

Runs linters asynchronously on buffer events (`BufEnter`, `BufWritePost`, `InsertLeave`). Uses `version = false` because the plugin has no releases.

**Active linters** (others are commented out but available to enable):

- `python`: `pylint`
- `latex` and `tex`: `chktex`
- `markdown`: `markdownlint`

To enable a linter for another filetype, uncomment the relevant line in `linters_by_ft`.

| Key          | Description                                   |
| ------------ | --------------------------------------------- |
| `<leader>ml` | Manually trigger linting for the current file |

---

## Keymap Reference

For keymap reference see [`KEYMAPS.md`](./KEYMAPS.md) or run `:WhichKey` in nvim.

---

## Maintenance

### Checking for Updates

Run `:Lazy` to open the lazy.nvim UI. It shows the status of all plugins and highlights any with available updates.

### Updating Plugins

```
:Lazy update
```

This updates all plugins to their latest allowed version (respecting the `version` constraint in each spec) and writes the new commit hashes to [`lazy-lock.json`](./lazy-lock.json).

To update a single plugin:

```
:Lazy update telescope.nvim
```

### Restoring a Known-Good State

If an update breaks something, revert all plugins to the versions recorded in [`lazy-lock.json`](./lazy-lock.json):

```
:Lazy restore
```

This is why committing `lazy-lock.json` after each verified working update is important. It lets you roll back at any time.

### Adding a New Plugin

1. Create a new `.lua` file in the appropriate subfolder (`ui/`, `editor/`, or `lsp/`).
2. Return a lazy.nvim plugin spec from the file. Follow the standard template:

   ```lua
   return {
       "author/plugin-name",
       version = "*",       -- or version = false if no semver releases exist
       event = "VeryLazy",  -- or another appropriate trigger
       config = function()
           require("plugin-name").setup({ ... })
       end,
   }
   ```

   Or for simpler configs:

   ```lua
   return {
        "author/plugin-name",
        version = "*",
        event = "VeryLazy",
        opts = { ... },      -- passed directly to the plugin's setup function
    }
   ```

3. Restart Neovim or run `:Lazy sync`. The new file is picked up automatically.

### Checking Plugin Version Strategy

Before adding or updating a plugin, check its GitHub releases page:

- If it uses standard `vX.Y.Z` tags: the global `version = "*"` default applies, no override needed.
- If it has no releases, or uses a non-standard format: add `version = false` to the spec.
- If it is a major-version-locked API: use a specific constraint like `version = "^2.0"`.

### Updating LSP Servers and Tools

Mason manages LSP servers, linters, and formatters independently of lazy.nvim.

- Open `:Mason` to see all installed packages and check for updates.
- To add a new server, add it to the `ensure_installed` list in [`lua/plugins/lsp/mason.lua`](./lua/plugins/lsp/mason.lua), then re-open Neovim or run `:MasonToolsInstall`.
- To enable a new server in Neovim, also add it to the `vim.lsp.enable({ ... })` list in [`lua/plugins/lsp/lsp-config.lua`](./lua/plugins/lsp/lsp-config.lua).

### Known Issues

| Issue                                  | Status                                    | Workaround                                                                                                                                                                   |
| -------------------------------------- | ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `nvim-treesitter` is archived          | Permanent (repo read-only since Apr 2026) | Both branches are frozen but functional. A `master` branch fallback is preserved as a comment in [`lua/plugins/editor/treesitter.lua`](./lua/plugins/editor/treesitter.lua). |
| Telescope `mouse_click` error (v0.2.x) | Open bug, not fixed upstream              | Stub functions are injected in the `config` function. See [`lua/plugins/editor/telescope.lua`](./lua/plugins/editor/telescope.lua).                                          |
| `mason.nvim` organization move         | Pending                                   | The repo moved to `mason-org/mason.nvim`. The old `williamboman/mason.nvim` URL still redirects. Update the spec URL when convenient.                                        |
