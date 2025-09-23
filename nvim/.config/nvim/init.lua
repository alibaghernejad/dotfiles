--test    
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

--===== Make line numbers default =====--
-- + Standard line numbering
-- + Relative Line numbering
-- + hybrid line Numbering (Use both of the standard and relative line numbering together)

-- Standard line numbering
vim.o.number = true -- short command: set nu/ set nonu

-- Relative line numbering
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true -- set rnu/ set nornu

--===== Mouse Support =====---
-- Enable mouse mode, can be useful for resizing splits for example!
-- Docs :help mouse
vim.o.mouse = 'a'

--===== Mode =====--
-- Showing the mode.
-- ou may Don't want to show the mode by setting it to false, since it's already in the status line
vim.o.showmode = true

--===== Options =====--
-- Enable break indent
-- The changes are actually visible when there is a long line of text and `wrap` is enable with `set wrap` or `vim.o.wrap = true`
-- See: `:help breakindent`
vim.o.breakindent = true

-- Save Undo History
-- By default vim/nvim forget undo history once you close a file or program.
-- By setting `undofile` option to `true`, nvim save undo history to file on disk 
-- So that after reopening the file or the program, you can continue undo/redo your changes.
vim.o.undofile = true 

-- By enabling `undodile`, `undodir` located at`$HOME/local/state/nvim/undo` by default.
-- Optionaly setting the location of the und file by uncommenting the below line.
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"

-- Make sure the directory exists
vim.fn.mkdir(vim.o.undodir, "p")

-- Case-insensitive searching
vim.o.ignorecase = true

-- But if the search contains capital letters, it becomes case-sensitive
-- If you ant to FORCE case Sensivity, regardless of `smartcase` you can use
-- `\C` in your query. `:/\CFoo` for example.
vim.o.smartcase = true

-- Enable/disable sign-column. (Most-left column)
-- where symbols like Git changes, diagnostics, breakpoints, etc. appear.
-- See: `:help signs`
vim.o.signcolumn = "yes"


-- Decrease updatetime
-- WHAT: Set the time (in ms), before Neovim trigger the `CursorHold` event and `Swap Out`changes to disk for swap files.
-- WHY: Decreasing updatetime to 250ms makes plugins like `git signs`, `LSP Diagnosticss` or `Cursor hover docs` feels more responsive. (in compare to default 400ms (4 sec))
-- Default: `4000` ms (4sec)
-- See: `:help updatetime`
-- See: `:help crash-recovery`
-- See: `:help CursorHold`
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- WHAT: Set the time (in ms) Neovim waits for a mapped key sequence to complete. 
-- WHY: Makes key mapping (leader-based mappings for example) feels snappier. For <leader<q> that is a keymap for `Quick List Diagnostics`, means you must enter the sequence of charachtesrs in 300ms not 1000ms.
-- Default: `1000` ms (1sec)
-- See: `:help timeoutlen`
vim.o.timeoutlen= 300

--===== Windows =====--
-- Configure split behavior
-- vertical split
-- new vertical split go right
vim.o.splitright = true

-- new vertical windows go left.
-- Vertical splits (`:vsplit`) will open to the left of the current windows. (Instead of right)
-- set nosplitright
--
-- horizontal split
-- new horizontal split go up.
-- See: `:vsplit` or `vsp`
vim.o.splitbelow = true

-- new horizontal windows go up.
-- Horizontal splits (`:split`) will open above the current windows. (Instead of below)
-- set nosplitbelow

--===== Clipboard =====--
-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

--===== Diagnostic =====--
-- SEE: `:help diagnostic`
-- Quickfix list in Normal mode.
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Can run in command mode via `:lua vim.diagnostic.setloclist()` or `lopen`

--===== Terminal Mode =====--
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")
