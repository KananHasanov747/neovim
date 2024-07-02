-- TODO: startup time is high for both plugins
return {
	-- Package Manager for LSP, Formatters, DAP servers, and linters
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({})

			local formatters = {
				"prettier",
				--htmldjango
				"djlint", -- formatter, linter
				-- python
				"-autopep8",
				"-black",
				"-isort",
				-- lua
				"stylua",
			}
			local dap = {}
			local linters = {
				-- python
				"-flake8",
				"mypy",
			}
			local ensure_installed = { dap, linters, formatters }

			local mr = require("mason-registry")
			for _, tbl in ipairs(ensure_installed) do
				for _, package in ipairs(tbl) do
					-- use "-" before the package name (like, "-stylua") to uninstall it
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
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ruff_lsp", -- python lsp, formatter and linter
					"html",
					"cssls",
					"tsserver",
					"tailwindcss",
					"marksman", -- markdown
				},
				auto_install = true,
			})
		end,
	},
}
