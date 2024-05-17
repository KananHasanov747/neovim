local o = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

local options = {
	clipboard = "unnamedplus",
	cursorline = true,
	expandtab = true,
	formatoptions = "jcroqlnt", -- tcqj
	ignorecase = true,
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
