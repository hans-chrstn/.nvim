return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	cmd = { "BqfAutoToggle", "BqfDisable", "BqfEnable", "BqfToggle" },
	keys = {
		{ "<leader>xq", "<cmd>copen<cr>", desc = "Open native quickfix" },
	},
	opts = {
		auto_resize_height = true,
		preview = {
			border = "none",
			winblend = 0,
			delay_syntax = 80,
		},
	},
}
