return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    -- notify_on_error = false,
    format_on_save = function(bufnr)
      -- Define filetypes where LSP fallback formatting should be disabled
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      python = { "ruff_format", "ruff_fix" }, -- formatting and import sorting
      lua = { "stylua" },
      ["*"] = { "trim_whitespace" },
    },
  },
}
