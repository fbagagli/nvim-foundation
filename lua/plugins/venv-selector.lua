return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim' },
  opts = {
    -- Auto-select virtual environments from common locations
    name = { "venv", ".venv", "env", ".env" },
  },
  keys = {
    { '<leader>cv', '<cmd>VenvSelect<cr>', desc = 'Select VirtualEnv' },
  },
}
