return {
	"stevearc/aerial.nvim",
	cmd = {
		"AerialClose",
		"AerialCloseAll",
		"AerialInfo",
		"AerialNavClose",
		"AerialNavOpen",
		"AerialNavToggle",
		"AerialOpen",
		"AerialOpenAll",
		"AerialToggle",
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		backends = { "treesitter", "lsp", "markdown", "man" },
		layout = {
			max_width = { 40, 0.25 },
			min_width = 24,
			default_direction = "prefer_right",
			placement = "edge",
			resize_to_content = true,
			win_opts = {
				winhighlight = table.concat({
					"Normal:Normal",
					"NormalNC:NormalNC",
					"EndOfBuffer:EndOfBuffer",
					"SignColumn:SignColumn",
				}, ","),
			},
		},
		attach_mode = "global",
		lazy_load = true,
		disable_max_lines = 10000,
		disable_max_size = 1024 * 1024,
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Method",
			"Module",
			"Struct",
		},
	},
	keys = {
		{
			"<leader>co",
			"<cmd>AerialToggle right<cr>",
			desc = "Toggle code outline",
		},
	},
}
