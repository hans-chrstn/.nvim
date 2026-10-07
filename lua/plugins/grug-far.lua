return {
	"MagicDuck/grug-far.nvim",
	cmd = { "GrugFar", "GrugFarWithin" },
	keys = {
		{ "<leader>sr", "<cmd>GrugFar<cr>", desc = "Search and replace project" },
		{ "<leader>sr", ":GrugFar<cr>", mode = "x", desc = "Search and replace selection" },
	},
	opts = {
		helpLine = { enabled = true },
		transient = true,
	},
}
