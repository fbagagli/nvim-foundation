-- Native 0.11 config file
return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" }, -- REQUIRED for auto-start
  root_markers = { "pyproject.toml", "setup.py", ".git" },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
