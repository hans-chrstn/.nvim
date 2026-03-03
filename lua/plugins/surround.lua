return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	opts = {},
	keys = {
		{ "ys", desc = "Add surround" },
		{ "yss", desc = "Add surround to line" },
		{ "yS", desc = "Add surround to line" },
		{ "ySS", desc = "Add surround to line" },
		{ "S", mode = "v", desc = "Add surround in visual" },
		{ "gS", mode = "v", desc = "Add surround in visual line" },
		{ "ds", desc = "Delete surround" },
		{ "cs", desc = "Change surround" },
		{ "cS", desc = "Change surround line" },
		{ "<C-g>s", mode = "i", desc = "Add surround in insert" },
		{ "<C-g>S", mode = "i", desc = "Add surround in insert line" },
	},
}
