return {
	"stevearc/conform.nvim",
	enabled = true, -- false if "none-ls.nvim" is activated
	event = "VeryLazy",
	dependencies = { "mason.nvim" },
	cmd = "ConformInfo",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
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
				html = { "prettier" },
				htmldjango = { "prettier" },
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
