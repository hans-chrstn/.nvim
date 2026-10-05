local obsidian = require("dotfiles.obsidian")

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	cmd = "Obsidian",
	opts = {
		legacy_commands = false,
		picker = { name = "snacks.picker" },
		ui = { enable = false },
		workspaces = obsidian.workspaces,
	},
}
