local o = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

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
	relativenumber = true,
	shiftwidth = 2,
	showmode = false,
	signcolumn = "yes",
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitkeep = "screen",
	splitright = true,
	tabstop = 2,
	termguicolors = true,
}

for k, v in pairs(options) do
	o[k] = v
end
