return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = { enabled = false },
			search = { enabled = false },
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		{
			"<C-Space>",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter({
					actions = {
						["<C-Space>"] = "next",
						["<BS>"] = "prev",
					},
				})
			end,
			desc = "Flash Treesitter selection",
		},
	},
}
