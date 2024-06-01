-- TODO: the plugin is too slow during the startuptime
return {
	"hrsh7th/nvim-cmp",
	-- event = "InsertEnter",
	event = "VeryLazy",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			dependencies = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"onsails/lspkind.nvim",
				"roobert/tailwindcss-colorizer-cmp.nvim",
				{
					"L3MON4D3/LuaSnip",
					dependencies = {
						"saadparwaiz1/cmp_luasnip",
						"rafamadriz/friendly-snippets",
					},
				},
				-- "hrsh7th/cmp-emoji",
				-- { "garymjr/nvim-snippets", opts = { friendly_snippets = true } },
			},
		},
	},

	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local cmp_tailwind = require("tailwindcss-colorizer-cmp")

		local luasnip = require("luasnip")
		luasnip.filetype_extend("javascriptreact", { "html" }) -- snippets for "jsx" from "html"
		luasnip.filetype_extend("typescriptreact", { "html" }) -- snippets for "tsx" from "html"
		luasnip.filetype_extend("htmldjango", { "html" }) -- snippets for "htmldjango" from "html"
		require("luasnip.loaders.from_vscode").lazy_load()

		local source_mapping = {
			nvim_lsp = "[LSP]",
			-- nvim_lua = "[LUA]",
			luasnip = "[SNIP]",
			buffer = "[BUF]",
			path = "[PATH]",
			copilot = "[COP]",
			-- treesitter = "[TREE]",
		}

		lspkind.init({
			symbol_map = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "",
				Copilot = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			},
		})

		local blend = 15
		local _highlights = {
			{ 0, "CmpPMenu", { default = true, blend = blend } }, -- #19212f
			{ 0, "CmpPMenuSel", { link = "PMenuSel" } }, -- #2f3a4a #3c4759
			{ 0, "CmpPMenuBorder", { default = true, blend = blend } }, -- #8296b5
			{ 0, "CmpPDoc", { default = true, blend = blend } },
			{ 0, "CmpPDocBorder", { default = true, blend = blend } },
		}

		for _, h in ipairs(_highlights) do
			vim.api.nvim_set_hl(h[1], h[2], h[3])
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

		local opts = {
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),

				completion = {
					border = border("CmpPMenuBorder"),
					winhighlight = "Normal:CmpPMenu,CursorLine:CmpPMenuSel,Search:None",
				},
				documentation = {
					border = border("CmpPDocBorder"),
					winhighlight = "Normal:CmpPDoc",
				},
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
					before = function(entry, vim_item)
						cmp_tailwind.formatter(entry, vim_item)
						return vim_item
					end,
					menu = source_mapping,
				}),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			view = {
				entries = {
					name = "custom", -- can be "custom", "wildmenu" or "native"
					selection_order = "near_cursor",
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
				{ name = "emoji" },
				{ name = "copilot" },
			}, {
				{ name = "buffer" },
			}),
			sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,

					-- Below is the default comparitor list and order for nvim-cmp
					cmp.config.compare.offset,
					-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		}

		local completion = {
			completeopt = "menu,menuone,noselect",
			-- autocomplete = false,
		}
		local cmdline_mapping = cmp.mapping.preset.cmdline({
			["<Up>"] = {
				c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			},
			["<Down>"] = {
				c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			},
			["<CR>"] = { c = cmp.mapping.confirm() },
			["<C-e>"] = { c = cmp.mapping.abort() },
		})

		cmp.setup(opts)
		cmp.setup.cmdline(":", {
			completion = completion,
		    -- stylua: ignore
			view = { entries = "custom" },
			mapping = cmdline_mapping,
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					autocomplete = false,
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
		cmp.setup.cmdline("/", {
			completion = completion,
		    -- stylua: ignore
			view = { entries = "custom" },
			mapping = cmdline_mapping,
			sources = {
				{ name = "buffer" },
			},
		})
		cmp.setup.cmdline("?", {
			completion = completion,
		    -- stylua: ignore
			view = { entries = "custom" },
			mapping = cmdline_mapping,
			sources = {
				{ name = "buffer" },
			},
		})
	end,
}
