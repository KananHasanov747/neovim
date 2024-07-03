local M = {}
local env = require("kanan.configs.heirline.env")
local utils = require("heirline.utils")

M.TablineFileName = {
	provider = function(self)
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return { bold = self.is_active or self.is_visible }
	end,
}

M.TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
		end,
		provider = "",
		hl = { fg = "white" },
		env.Space(1),
	},
	{
		condition = function(self)
			return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
				or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
		end,
		provider = function(self)
			if not vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
				return ""
			end
		end,
		hl = { fg = "orange" },
	},
}

M.TablineFileBlock = utils.insert({
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then -- close on mouse middle click
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	{
		provider = function(self)
			return (self.is_active or self.is_visible) and "┃" or "│"
		end,
		hl = function(self)
			return { fg = (self.is_active or self.is_visible) and "blue" or "gray" }
		end,
	},
	-- hl = function(self)
	-- 	return { bg = (self.is_active or self.is_visible) and "red" }
	-- end,
}, env.Space(1), env.FileIcon, M.TablineFileName, env.Space(1), M.TablineFileFlags)

M.TablineCloseButton = {
	condition = function(self)
		return self.filename ~= ""
	end,
	env.Space(1),
	provider = "󰅖",
	hl = function(self)
		return { fg = (self.is_active or self.is_visible) and "red" }
	end,
	on_click = {
		callback = function(_, minwid)
			vim.schedule(function()
				vim.api.nvim_buf_delete(minwid, { force = false })
				vim.cmd.redrawtabline()
			end)
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_close_buffer_callback",
	},
}

M.TablineBufferBlock = {
	M.TablineFileBlock,
	M.TablineCloseButton,
	env.Space(1),
}

local get_bufs = function()
	return vim.tbl_filter(function(bufnr)
		return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
	end, vim.api.nvim_list_bufs())
end

-- initialize the buflist cache
local buflist_cache = {}

-- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
	callback = function()
		vim.schedule(function()
			local buffers = get_bufs()
			for i, v in ipairs(buffers) do
				buflist_cache[i] = v
			end
			for i = #buffers + 1, #buflist_cache do
				buflist_cache[i] = nil
			end

			-- -- check how many buffers we have and set showtabline accordingly
			-- if #buflist_cache > 1 then
			-- 	vim.o.showtabline = 2 -- always
			-- elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
			-- 	vim.o.showtabline = 1 -- only when #tabpages > 1
			-- end
			if vim.bo.filetype ~= "dashboard" then
				vim.o.showtabline = 2
			end
		end)
	end,
})

M.BufferLine = utils.make_buflist(
	M.TablineBufferBlock,
	{ provider = " ", hl = { fg = "gray" } },
	{ provider = " ", hl = { fg = "gray" } },
	-- out buf_func simply returns the buflist_cache
	function()
		return buflist_cache
	end,
	-- no cache, as we're handling everything ourselves
	false
)

M.TabLineOffset = {
	condition = function(self)
		local win = vim.api.nvim_tabpage_list_wins(0)[1]
		local bufnr = vim.api.nvim_win_get_buf(win)
		self.winid = win

		if vim.bo[bufnr].filetype == "neo-tree" then
			self.title = "File Explorer"
			return true
			-- elseif vim.bo[bufnr].filetype == "TagBar" then
			--     ...
		end
	end,

	provider = function(self)
		local title = self.title
		local width = vim.api.nvim_win_get_width(self.winid)
		local pad = math.ceil((width - #title) / 2)
		return string.rep(" ", pad) .. title .. string.rep(" ", pad)
	end,

	hl = { fg = "blue", bold = true },
}

M.TabLine = { M.TabLineOffset, M.BufferLine }

return M
