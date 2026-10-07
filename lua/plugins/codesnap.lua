return {
	"mistricky/codesnap.nvim",
	version = "^2.0.0",
	cmd = {
		"CodeSnap",
		"CodeSnapASCII",
		"CodeSnapHighlight",
		"CodeSnapSave",
		"CodeSnapHighlightSave",
	},
	keys = {
		{ "<leader>cS", "<cmd>CodeSnap<cr>", mode = "x", desc = "Copy code snapshot" },
	},
	opts = {
		show_line_number = true,
		show_workspace = true,
	},
}
