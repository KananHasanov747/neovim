-- TODO: startup time is high for both plugins
return {
	-- Package Manager for LSP, Formatters, DAP servers, and linters
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({})

			local formatters = {
				"stylua",
			}
			local dap = {}
			local linters = {}
			local ensure_installed = { dap, linters, formatters }

			local mr = require("mason-registry")
			for _, tbl in ipairs(ensure_installed) do
				for _, package in ipairs(tbl) do
					-- use "-" before the package name "-stylua" to uninstall it
					if package:find("%-") ~= nil then
						local ok, pkg = pcall(mr.get_package, package:sub(2))
						if ok and pkg:is_installed() then
							pkg:uninstall()
						end
					else
						local ok, pkg = pcall(mr.get_package, package)
						if ok and not pkg:is_installed() then
							pkg:install()
						end
					end
				end
			end
		end,
	},
	-- Package Manager for LSP installation
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ruff_lsp",
				},
				auto_install = true,
			})
		end,
	},
}
