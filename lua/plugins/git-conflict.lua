return {
	"akinsho/git-conflict.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		default_mappings = {
			ours = "co",
			theirs = "ct",
			none = "c0",
			both = "cb",
			next = "]x",
			prev = "[x",
		},
		default_commands = true,
		disable_diagnostics = true,
		list_opener = "copen",
	},
	keys = {
		{ "<leader>gxl", "<cmd>GitConflictListQf<cr>", desc = "List merge conflicts" },
	},
}
