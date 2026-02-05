-- LEADER KEY (Must be set first)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- LINE NUMBERS
vim.opt.number = true
vim.opt.relativenumber = true

-- INDENTATION
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- SEARCH BEHAVIOR
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- VISUAL FEEDBACK
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

-- Enable 24-bit color (optional, but requested to be here)
vim.opt.termguicolors = true

-- EDITING BEHAVIOR
vim.opt.mouse = 'a'
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus' end
)
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- SPLIT BEHAVIOR
vim.opt.splitright = true
vim.opt.splitbelow = true

-- WHITESPACE DISPLAY
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Disable netrw globally (Recommended for NvimTree users)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
