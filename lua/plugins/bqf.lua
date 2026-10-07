return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	cmd = { "BqfAutoToggle", "BqfDisable", "BqfEnable", "BqfToggle" },
	opts = {
		auto_resize_height = true,
		preview = {
			border = "rounded",
			winblend = 0,
			delay_syntax = 80,
		},
	},
}
