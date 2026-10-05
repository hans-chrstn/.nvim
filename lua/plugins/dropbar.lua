return {
	"Bekaboo/dropbar.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	keys = {
		{
			"<leader>;",
			function()
				require("dropbar.api").pick()
			end,
			desc = "Pick breadcrumb",
		},
		{
			"[;",
			function()
				require("dropbar.api").goto_context_start()
			end,
			desc = "Go to context start",
		},
		{
			"];",
			function()
				require("dropbar.api").select_next_context()
			end,
			desc = "Select next context",
		},
	},
}
