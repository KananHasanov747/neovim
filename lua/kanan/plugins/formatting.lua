return {
	"stevearc/conform.nvim",
	enabled = true, -- false if "none-ls.nvim" is activated
	event = "VeryLazy",
	dependencies = { "mason.nvim" },
	cmd = "ConformInfo",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				vue = { "prettier" },
				yaml = { "prettier" },
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
