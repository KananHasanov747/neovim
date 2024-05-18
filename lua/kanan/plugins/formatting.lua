return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	dependencies = { "mason.nvim" },
	cmd = "ConformInfo",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
				async = false,
				quiet = false,
			},
		})
	end,
}
