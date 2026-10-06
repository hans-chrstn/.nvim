return {
	"rachartier/tiny-code-action.nvim",
	event = "LspAttach",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		backend = "vim",
		picker = "snacks",
	},
}
