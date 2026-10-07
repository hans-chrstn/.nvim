return {
	"mrjones2014/smart-splits.nvim",
	keys = {
		{
			"<C-h>",
			function()
				require("smart-splits").move_cursor_left()
			end,
			desc = "Focus window left",
		},
		{
			"<C-j>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			desc = "Focus window below",
		},
		{
			"<C-k>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			desc = "Focus window above",
		},
		{
			"<C-l>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			desc = "Focus window right",
		},
		{
			"<C-Left>",
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize window left",
		},
		{
			"<C-Down>",
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize window down",
		},
		{
			"<C-Up>",
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize window up",
		},
		{
			"<C-Right>",
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize window right",
		},
	},
	opts = {
		default_amount = 3,
		at_edge = "stop",
	},
}
