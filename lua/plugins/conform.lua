return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			python = { "ruff_format", "ruff_fix" }, -- formatting and import sorting
			["*"] = { "trim_whitespace" },
		},
	},
}
