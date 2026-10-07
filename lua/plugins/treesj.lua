return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
	keys = {
		{
			"<leader>cj",
			function()
				require("treesj").toggle()
			end,
			desc = "Split/join syntax node",
		},
		{
			"<leader>cJ",
			function()
				require("treesj").toggle({ split = { recursive = true } })
			end,
			desc = "Split/join syntax node recursively",
		},
	},
	opts = {
		use_default_keymaps = false,
		max_join_length = 120,
	},
}
