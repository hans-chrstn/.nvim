return {
	"gbprod/yanky.nvim",
	dependencies = { "folke/snacks.nvim" },
	cmd = { "YankyClearHistory", "YankyRingHistory" },
	keys = {
		{
			"<leader>sy",
			function()
				Snacks.picker.yanky()
			end,
			mode = { "n", "x" },
			desc = "Yank history",
		},
		{ "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after cursor" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before cursor" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put after and move cursor" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put before and move cursor" },
		{ "]y", "<Plug>(YankyNextEntry)", desc = "Next yank entry" },
		{ "[y", "<Plug>(YankyPreviousEntry)", desc = "Previous yank entry" },
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after line" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before line" },
	},
	opts = {
		ring = {
			history_length = 100,
			storage = "shada",
		},
		preserve_cursor_position = {
			enabled = true,
		},
	},
}
