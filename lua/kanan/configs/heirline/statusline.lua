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
}

M.GitBranch = utils.insert(M.Git, {
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
})

M.GitStatus = utils.insert(M.Git, {
	on_click = {
		callback = function()
			require("telescope.builtin").git_status()
		end,
		name = "heirline_git_status",
	},
	env.Space(2),
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "git_add" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "git_del" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "git_change" },
	},
})

M.FileType = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

M.FileTypeName = {
	provider = function(self)
		return vim.bo.filetype ~= "" and vim.bo.filetype or vim.bo.buftype
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

M.FileType = utils.insert(M.FileType, env.Space(2), env.FileIcon, M.FileTypeName, M.FileFlags)

M.Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%l:%L %P",
	hl = { bg = "None" },
	env.Space(2),
}

M.Time = {
	provider = os.date("%H:%M:%S"),
	hl = { bg = "None" },
	env.Space(2),
}

M.LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },

	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return "  " .. table.concat(names, ", ")
	end,
	hl = { fg = "bright_fg" },
	on_click = {
		callback = function()
			vim.cmd("LspInfo")
		end,
		name = "heirline_lsp_info",
	},
	env.Space(2),
}

M.Diagnostics = {
	env.Space(2),

	condition = conditions.has_diagnostics,

	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	on_click = {
		callback = function()
			require("telescope.builtin").diagnostics()
		end,
		name = "heirline_diagnostics",
	},

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = "diag_error" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = "diag_warn" },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = "diag_info" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = "diag_hint" },
	},
}

return M
