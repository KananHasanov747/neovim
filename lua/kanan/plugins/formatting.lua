return {
	"stevearc/conform.nvim",
	enabled = true, -- false if "none-ls.nvim" is activated
	event = "VeryLazy",
	dependencies = { "mason.nvim" },
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				-- djlint = {
				-- 	args = { "$FILENAME", "--profile=django", "--indent=2", '--ignore="H016,H030,H031,T003"' },
				-- },
				prettier = {
					options = {
						ft_parsers = {
							javascript = "babel",
							javascriptreact = "babel",
							typescript = "typescript",
							typescriptreact = "typescript",
							vue = "vue",
							css = "css",
							scss = "scss",
							less = "less",
							html = "html",
							htmldjango = "html",
							json = "json",
							jsonc = "json",
							yaml = "yaml",
							markdown = "markdown",
							["markdown.mdx"] = "mdx",
							graphql = "graphql",
							handlebars = "glimmer",
						},
					},
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" }, -- ruff_lsp
				html = { "prettier" },
				htmldjango = { "djlint" },
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
				timeout_ms = 3000,
				lsp_fallback = true,
				async = false,
				quiet = false,
			},
		})
	end,
}
