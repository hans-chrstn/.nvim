return {
	"NStefan002/screenkey.nvim",
	version = "*",
	cmd = "Screenkey",
	keys = {
		{ "<leader>uk", "<cmd>Screenkey toggle<cr>", desc = "Toggle pressed-key display" },
	},
	opts = {
		win_opts = {
			border = "rounded",
		},
		clear_after = 2,
		disable = {
			buftypes = { "prompt", "terminal" },
			events = true,
		},
	},
}
