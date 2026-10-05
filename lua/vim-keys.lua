vim.g.mapleader = " "
vim.keymap.set("n", "<leader>dd", function()
	vim.diagnostic.open_float({ focus = false })
end, { silent = true, desc = "Open diagnostics float" })
vim.keymap.set("n", "<leader>ch", "<cmd>checkhealth dotfiles<cr>", { desc = "Check config dependencies" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus window right" })

vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close current window" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", { desc = "Close other windows" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bc", function()
	Snacks.bufdelete()
end, { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bP", function()
	Snacks.picker.buffers()
end, { desc = "Pick buffer" })

vim.keymap.set("n", "<leader><Tab><Tab>", "<cmd>tabnew<cr>", { desc = "New tab page" })
vim.keymap.set("n", "<leader><Tab>n", "<cmd>tabnext<cr>", { desc = "Next tab page" })
vim.keymap.set("n", "<leader><Tab>p", "<cmd>tabprevious<cr>", { desc = "Previous tab page" })
vim.keymap.set("n", "<leader><Tab>c", function()
	if vim.fn.tabpagenr("$") > 1 then
		vim.cmd.tabclose()
	else
		vim.notify("Cannot close the only tab page", vim.log.levels.INFO)
	end
end, { desc = "Close current tab page" })
vim.keymap.set("n", "<leader><Tab>o", "<cmd>tabonly<cr>", { desc = "Close other tab pages" })
