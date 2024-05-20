-- TODO: startup time is high
return {
	"neovim/nvim-lspconfig",
	-- enabled = false,
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				source = "if_many",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = false,
		})

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						telemetry = {
							enable = false,
						},
						hint = {
							enable = true,
						},
					},
				},
			},
			html = {
				filetypes = { "html", "htmldjango" },
			},
			ruff_lsp = {},
			cssls = {},
			tailwindcss = {
				root_dir = function(fname)
					return lspconfig.util.root_pattern(
						"tailwind.config.js",
						"tailwind.config.ts",
						"./theme/static_src/tailwind.config.js"
					)(fname) or lspconfig.util.root_pattern("postcss.config.js", "postcss.config.ts")(fname) or lspconfig.util.find_package_json_ancestor(
						fname
					) or lspconfig.util.find_node_modules_ancestor(fname) or lspconfig.util.find_git_ancestor(
						fname
					)
				end,
			},
		}

		for lsp, values in pairs(servers) do
			lspconfig[lsp].setup({
				-- on_attach = on_attach
				capabilties = capabilities,
				root_dir = values.root_dir,
				settings = values.settings,
				filetypes = values.filetypes,
			})
		end

		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	end,
}
