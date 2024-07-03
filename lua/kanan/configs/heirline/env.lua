local M = {}
local utils = require("heirline.utils")

M.Align = { provider = "%=", hl = { bg = "None" } }
M.Space = function(space)
	return { provider = string.rep(" ", space), hl = { bg = "None" } }
end

M.FileIcon = {
	init = function(self)
		self.type = vim.bo[self.bufnr and self.bufnr or 0].filetype ~= ""
				and vim.bo[self.bufnr and self.bufnr or 0].filetype
			or vim.bo[self.bufnr and self.bufnr or 0].buftype
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(self.filename, self.type, { default = true })
	end,
	provider = function(self)
		return (self.type == "terminal" and "" or self.icon) .. " "
	end,
	hl = function(self)
		if self.bufnr and not (self.is_active or self.is_visible) then
			return { bg = "None" }
		else
			return { fg = self.icon_color }
		end
	end,
}

function M.setup_colors()
	return {
		bright_bg = utils.get_highlight("Folded").bg,
		bright_fg = utils.get_highlight("Folded").fg,
		red = utils.get_highlight("DiagnosticError").fg,
		dark_red = utils.get_highlight("DiffDelete").bg,
		green = utils.get_highlight("String").fg,
		blue = utils.get_highlight("Function").fg,
		gray = utils.get_highlight("NonText").fg,
		orange = utils.get_highlight("Number").fg,
		purple = utils.get_highlight("Statement").fg,
		cyan = utils.get_highlight("Special").fg,
		diag_warn = utils.get_highlight("DiagnosticWarn").fg,
		diag_error = utils.get_highlight("DiagnosticError").fg,
		diag_hint = utils.get_highlight("DiagnosticHint").fg,
		diag_info = utils.get_highlight("DiagnosticInfo").fg,
		git_del = utils.get_highlight("diffDeleted").fg,
		git_add = utils.get_highlight("diffAdded").fg,
		git_change = utils.get_highlight("diffChanged").fg,
	}
end

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		utils.on_colorscheme(M.setup_colors)
	end,
	group = "Heirline",
})

return M
