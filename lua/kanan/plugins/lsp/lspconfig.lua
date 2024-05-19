-- TODO: startup time is high
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
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
