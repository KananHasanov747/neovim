local M = {}
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local env = require("kanan.configs.heirline.env")

M.Mode = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	static = {
		mode_colors = {
			n = "blue",
			i = "green",
			v = "purple",
			V = "purple",
			["\22"] = "cyan",
			c = "orange",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		},
	},
	provider = function(self)
		return " "
	end,
	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return { bg = self.mode_colors[mode], bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

M.Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	env.Space(2),
	{ -- git branch name
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = { fg = "orange", bold = true },

		on_click = {
			callback = function()
				require("telescope.builtin").git_branches()
			end,
			name = "heirline_git_branches",
		},
	},
}

M.FileType = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
		self.type = vim.bo.filetype ~= "" and vim.bo.filetype or vim.bo.buftype
	end,
}

M.FileIcon = {
	init = function(self)
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(self.filename, self.type, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

M.FileTypeName = {
	provider = function(self)
		return self.type
	end,
	hl = { bg = "None" },
}

M.FileFlags = {
	env.Space(1),
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "",
		hl = { fg = "white" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = "",
		hl = { fg = "orange" },
	},
}

M.FileType = utils.insert(M.FileType, env.Space(2), M.FileIcon, M.FileTypeName, M.FileFlags)

M.Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%l:%L %P",
	hl = { bg = "None" },
	env.Space(2),
}

return M
