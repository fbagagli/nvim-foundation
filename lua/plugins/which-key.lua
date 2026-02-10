return {
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Load this last to ensure it picks up all other mappings
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Decrease the delay before the popup appears
  end,
  opts = {
    -- Configuration for the popup window style
    -- preset = "modern", -- "classic", "modern", "helix"
    icons = {
      -- set to false to disable all icons
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)

    -- Document existing key chains
    -- NOTE: You do not need to register individual mappings here if they 
    -- are defined with `desc` in other files.
    wk.add({
      -- Search Group (Matches telescope.lua)
      { "<leader>s", group = "[S]earch" },
      
      -- Code/LSP Group (Matches lspconfig.lua & conform)
      { "<leader>c", group = "[C]ode" },
      
      -- Debug Group (Matches debug.lua)
      { "<leader>d", group = "[D]ebug" },
      
      -- Workspace Group (LSP specific)
      { "<leader>w", group = "[W]orkspace" },
      
      -- Toggle Group (For UI toggles)
      { "<leader>u", group = "[U]I" },
    })
    -- 2. Register plain 'g' groups (Navigation/LSP)
    -- This enables the menu when you press 'g' and wait, showing your LSP options.
    wk.add({
      { "g", group = "[G]o / LSP" },
      { "gr", group = "[R]eferences / [R]ename" },
    })
  end,
}
