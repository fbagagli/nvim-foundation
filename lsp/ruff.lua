return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", ".git" },
  on_attach = function(client, bufnr)
    -- Disable hover in favor of basedpyright
    client.server_capabilities.hoverProvider = false
    -- Disable formatting in favor of conform.nvim
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
