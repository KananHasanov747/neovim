local M = {}
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local TabLine = require("kanan.configs.heirline.tabline")
local StatusLine = require("kanan.configs.heirline.statusline")
local WinBar = require("kanan.configs.heirline.winbar")

local env = require("kanan.configs.heirline.env")

return {
	opts = {
		colors = env.setup_colors,
		disable_winbar_cb = function(args)
			return conditions.buffer_matches({
				buftype = { "nofile", "prompt", "help", "quickfix" },
				filetype = { "Terminal", "^git.*", "fugitive", "Trouble", "dashboard" },
			}, args.buf)
		end,
	},
	tabline = {
		TabLine.TabLine,
	},
	winbar = {
		WinBar.Navic,
		env.Align,
	},
	statusline = {
		StatusLine.Mode,
		StatusLine.GitBranch,
		StatusLine.FileType,
		StatusLine.GitStatus,
		StatusLine.Diagnostics,
		env.Align,
		StatusLine.LSPActive,
		StatusLine.Ruler,
		StatusLine.Time,
		StatusLine.Mode,
	},
	-- statuscolumn = {},
}
