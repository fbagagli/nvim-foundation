-- lsp/clangd.lua
return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
    "-j=4", -- Adjust based on your available CPU cores
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git"
  },
  capabilities = {
    -- Offset encoding is often required by clangd to avoid conflicts with 
    -- other tools sharing the buffer in Neovim
    offsetEncoding = { "utf-16" }
  }
}
