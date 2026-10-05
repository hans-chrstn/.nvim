if vim.env.NVIM_LAZY_PATH then
	vim.opt.rtp:prepend(vim.env.NVIM_LAZY_PATH)
end

require("vim-options")
require("vim-keys")
require("dotfiles.health").setup()

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
	vim.schedule(function()
		vim.notify("lazy.nvim is unavailable. Run :checkhealth dotfiles", vim.log.levels.ERROR)
	end)
	return
end

lazy.setup("plugins", {
	rocks = {
		enabled = false,
	},
})
