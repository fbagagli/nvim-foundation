-- Native 0.11 config file
return {
  cmd = { "basedpyright-langserver", "--stdio" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
  settings = {
    basedpyright = {
      analysis = { typeCheckingMode = "standard" }
    }
  }
}
