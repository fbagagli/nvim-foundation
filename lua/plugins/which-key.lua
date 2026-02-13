return {
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Load this last to ensure it picks up all other mappings
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Decrease the delay before the popup appears
  end,
  opts = {
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    -- In Which-Key v3, mappings are defined declaratively in the spec array.
    -- This eliminates the need for a separate config function calling wk.add().
    spec = {
      -- Code Group: Contains <leader>cv from venv-selector.lua
      { "<leader>c", group = "[C]ode" },
      
      -- Search Group: Contains all <leader>s mappings from telescope.lua
      { "<leader>s", group = "[S]earch" },
      
      -- LSP/Navigation Groups: Contains g and gr mappings from lspconfig.lua
      { "g", group = "[G]o / LSP" },
      { "gr", group = "[R]eferences / [R]ename" },
    },
  },
}
