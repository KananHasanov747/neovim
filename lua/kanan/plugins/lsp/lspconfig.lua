return {
	"neovim/nvim-lspconfig",
	-- enabled = false,
	event = { "BufReadPre", "BufNewFile" },
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
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		local function on_attach(client, bufnr)
			local function buf_set_keymap(mode, key, func)
				vim.keymap.set(mode, key, func, { buffer = bufnr, silent = true })
			end

			-- require("lsp_signature").on_attach()

			-- Mapping
			buf_set_keymap("n", "K", vim.lsp.buf.hover)
		end

		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		-- local handlers = {
		-- 	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border("FloatBorder") }),
		-- 	["textDocument/signatureHelp"] = vim.lsp.with(
		-- 		vim.lsp.handlers.signature_help,
		-- 		{ border = border("FloatBorder") }
		-- 	),
		-- }

		local servers = {
			-- BUG: lua_ls is not working (though other servers are)
			lua_ls = {
				single_file_support = true,
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
				-- cmd = { "vscode-html-language-server", "--stdio" },
				filetypes = { "html", "htmldjango" },
				root_dir = lspconfig.util.root_pattern(".git", "package.json"),
			},
			ruff_lsp = {},
			cssls = {},
			tsserver = {
				enabled = true,
				single_file_support = true,
				root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = false,
						},
					},

					typescript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			},
			tailwindcss = {
				single_file_support = false,
				-- cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = { "html", "css", "javascript", "htmldjango" },
				root_dir = lspconfig.util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.cjs",
					"tailwind.config.ts"
				),
			},
		}

		-- disabling lsp formatters
		-- vim.lsp.buf.format({
		-- 	filter = function(client)
		-- 		return client.name ~= "html"
		-- 	end,
		-- })

		-- provides "capabalities" and "on_attach" to all servers
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local server_opts = servers[server_name] or {}
				-- server_opts["handlers"] = handlers
				server_opts["on_attach"] = on_attach
				server_opts["capabilities"] = capabilities
				lspconfig[server_name].setup(server_opts)
			end,
		})
	end,
}
