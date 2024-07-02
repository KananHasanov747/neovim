local o = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = "\\"

local options = {
	clipboard = "unnamedplus",
	confirm = true,
	cursorline = true,
	expandtab = true,
	formatoptions = "jcroqlnt", -- tcqj
	ignorecase = true,
	laststatus = 3,
	mouse = "a",
	number = true,
	numberwidth = 4,
	relativenumber = true,
	scrolloff = 4,
	-- sidescrolloff = 8,
	shiftwidth = 2,
	showmode = false,
	signcolumn = "yes",
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitkeep = "screen",
	splitright = true,
	-- statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} ",
	tabstop = 2,
	termguicolors = true,
	virtualedit = "block",
	-- winminwidth = 5,
	winfixwidth = true,
	winfixheight = true,
	-- wrap = false,

	-- nvim-ufo
	-- foldcolumn = "1",
	-- foldlevel = 99,
	-- foldlevelstart = 99,
	-- foldenable = true,
	-- fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
}

for k, v in pairs(options) do
	o[k] = v
end
