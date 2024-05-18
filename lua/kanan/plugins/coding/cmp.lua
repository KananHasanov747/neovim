return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	config = function()
		-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })

		-- Cmp OneDark
		-- vim.api.nvim_set_hl(0, "CmpDoc", { bg = "#abb2bf" })
		-- vim.api.nvim_set_hl(0, "CmpDocBorder", { bg = "#abb2bf", fg = "#abb2bf" })
		-- vim.api.nvim_set_hl(0, "CmpPMenu", { bg = "#1e222a" })
		-- vim.api.nvim_set_hl(0, "CmpSel", { link = "PmenuSel", bold = true })

		local cmp = require("cmp")
		opts = {
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
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
			}),
		}

		vscode_icons = {
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
		}
		vscode_style = {
			highlights = {
				-- gray
				{ 0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" } },
				-- blue
				{ 0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" } },
				{ 0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" } },
				-- light blue
				-- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
				-- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
				-- vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
				-- pink
				-- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
				-- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
				-- front
				-- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
				-- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
				-- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
			},
			completion = {
				auto_brackets = {},
				completeopt = "menu,menuone,noinsert",
			},
			formatting = {
				format = function(_, item)
					local icons = vscode_icons or ""
					if icons[item.kind] then
						item.kind = icons[item.kind] .. item.kind
					end
					return item
				end,
			},
		}

		atom_icons = {
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
		}
		atom_style = {
			highlights = {},
			completion = {
				auto_brackets = {},
				completeopt = "menu,menuone",
			},
			-- window = {
			-- 	completion = {
			-- 		side_padding = 0,
			-- 		winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
			-- 		scrollbar = false,
			-- 	},
			-- 	documentation = {
			-- 		border = {
			-- 			{ "╭", "CmpDocBorder" },
			-- 			{ "─", "CmpDocBorder" },
			-- 			{ "╮", "CmpDocBorder" },
			-- 			{ "│", "CmpDocBorder" },
			-- 			{ "╯", "CmpDocBorder" },
			-- 			{ "─", "CmpDocBorder" },
			-- 			{ "╰", "CmpDocBorder" },
			-- 			{ "│", "CmpDocBorder" },
			-- 		},
			-- 		winhighlight = "Normal:CmpDoc",
			-- 	},
			-- },
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(_, item)
					local icons = atom_icons
					local icon = icons[item.kind] or ""

					icon = " " .. icon .. " "
					item.menu = "   (" .. item.kind .. ")" or ""
					item.kind = icon

					return item
				end,
			},
		}

		style = vscode_style -- "vscode_style" or "atom_style"

		-- if style.highlights then
		-- 	for _, h in ipairs(style.highlights) do
		-- 		vim.api.nvim_set_hl(h)
		-- 	end
		-- end

		for k, v in pairs(style) do
			if k ~= "highlights" then
				opts[k] = v
			end
		end

		cmp.setup(opts)
	end,
}
