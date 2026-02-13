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
vim.opt.timeoutlen = 500

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

-- -----------------------------------------------------------------------------
-- DIAGNOSTIC DISPLAY CONFIGURATION
-- -----------------------------------------------------------------------------
-- Controls how errors, warnings, hints appear in the editor
vim.diagnostic.config({
    -- -- single line error
    -- virtual_text = {
    --     prefix = '●',  -- Symbol before diagnostic text
    --     spacing = 4,
    -- },
    virtual_text = false,
    virtual_lines = false,
    -- Define signs for the sign column directly in the config (Neovim 0.10+ API)
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.INFO] = 'I',
            [vim.diagnostic.severity.HINT] = 'H',
        },
    },
    -- Underline problematic code
    underline = true,
    -- Don't update diagnostics while typing (reduces noise)
    update_in_insert = false,
    -- Sort diagnostics by severity
    severity_sort = true,
    -- Floating window style
    float = {
        border = 'rounded',
        source = true,  -- Show which LSP produced the diagnostic
    },
})
