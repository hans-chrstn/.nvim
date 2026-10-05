return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = true,
		sign_priority = 8,
		keywords = {},
		gui_style = {
			fg = "NONE",
			bg = "BOLD",
		},
		merge_keywords = true,
		highlight = {
			multiline = true,
			multiline_pattern = "^.",
			multiline_context = 10,
			before = "",
			keyword = "wide",
			after = "fg",
			pattern = [[.*<(KEYWORDS)\s*:]],
			comments_only = true,
			max_line_len = 400,
			exclude = {},
		},
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "Identifier", "#FF00FF" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			pattern = [[\b(KEYWORDS):]],
		},
	},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next Todo Comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous Todo Comment",
		},
		{
			"<leader>st",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Search Todo Comments",
		},
	},
}
