local map = vim.keymap.set

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", noremap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", noremap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", noremap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", noremap = true })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", noremap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", noremap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", noremap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", noremap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", noremap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", noremap = true })
