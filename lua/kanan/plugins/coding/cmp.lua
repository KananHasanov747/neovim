-- TODO: startup time is high
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim", -- customizing cmp style
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
		},
	},
	config = function()
		local cmp = require("cmp")
		require("luasnip.loaders.from_vscode").lazy_load()

		style = "custom" -- "vscode" or "custom"
		-- main options
		opts = {
			-- comment "completion" and "formatting" for custom style
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					maxwidth = 50,
					ellipsis_char = "...",
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
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
				{ name = "luasnip" },
			}),
		}
		_icons = {
			vscode = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			},
			custom = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
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
		}

		_highlights = {
			vscode = {
				-- gray
				{ 0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" } },
				-- blue
				{ 0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" } },
				{ 0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" } },
				-- light blue
				{ 0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" } },
				{ 0, "CmpItemKindInterface", { link = "CmpItemKindVariable" } },
				{ 0, "CmpItemKindText", { link = "CmpItemKindVariable" } },
				-- pink
				{ 0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" } },
				{ 0, "CmpItemKindMethod", { link = "CmpItemKindFunction" } },
				-- front
				{ 0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" } },
				{ 0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" } },
				{ 0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" } },
			},
			custom = {
				{ 0, "CmpPmenu", { bg = "#1e222a" } },
				{ 0, "CmpSel", { bg = "#42464e" } },
				{ 0, "CmpBorder", { fg = "#1b1f27", bg = "#1b1f27" } },
				{ 0, "CmpDoc", { bg = "#1b1f27" } },
				{ 0, "CmpDocBorder", { link = "CmpBorder" } },
			},
		}

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

		_opts = {
			vscode = {
				completion = {
					auto_brackets = {},
					completeopt = "menu,menuone,noinsert",
				},
				formatting = {
					format = function(_, item)
						local icons = _icons.vscode or ""
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
			},
			custom = {
				completion = {
					auto_brackets = {},
					completeopt = "menu,menuone",
				},
				window = {
					completion = cmp.config.window.bordered({
						border = border("CmpDocBorder"),
						side_padding = 0,
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
						scrollbar = false,
					}),
					documentation = {
						border = "rounded",
						-- border = {
						-- { "╭", "CmpDocBorder" },
						-- { "─", "CmpDocBorder" },
						-- { "╮", "CmpDocBorder" },
						-- { "│", "CmpDocBorder" },
						-- { "╯", "CmpDocBorder" },
						-- { "─", "CmpDocBorder" },
						-- { "╰", "CmpDocBorder" },
						-- { "│", "CmpDocBorder" },
						-- },
						winhighlight = "Normal:CmpDoc,FloatBorder:CmpBorder,Cursorline:CmpSel,Search:None",
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(_, item)
						local icons = _icons.custom
						local icon = icons[item.kind] or ""

						icon = " " .. icon .. " "
						item.menu = "   (" .. item.kind .. ")" or ""
						item.kind = icon

						return item
					end,
				},
			},
		}

		-- if _highlights[style] then
		-- 	for _, h in ipairs(_highlights[style]) do
		-- 		vim.api.nvim_set_hl(h[1], h[2], h[3])
		-- 	end
		-- end
		--
		-- for k, v in pairs(_opts[style]) do
		-- 	opts[k] = v
		-- end

		cmp.setup(opts)
	end,
}
