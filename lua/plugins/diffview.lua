return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = {
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewFocusFiles",
		"DiffviewLog",
		"DiffviewOpen",
		"DiffviewRefresh",
		"DiffviewToggleFiles",
	},
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git diff view" },
		{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Git diff view" },
		{ "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repository history" },
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
	},
}
