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
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				source = "if_many",
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = false,
		})

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = {
			lua_ls = {
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
			ruff_lsp = {},
		}

		for lsp, settings in pairs(servers) do
			lspconfig[lsp].setup({
				-- on_attach = on_attach
				capabilties = capabilities,
				settings = settings,
			})
		end

		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	end,
}
