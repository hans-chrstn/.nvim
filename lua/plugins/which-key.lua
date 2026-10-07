return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "classic",
			icons = {
				breadcrumb = "»",
				separator = "",
				group = "+",
			},
			win = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<leader>/", group = "search" },
				{ "<leader>:", group = "search" },
				{ "<leader>a", group = "actions" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>c", group = "code" },
				{ "<leader>cp", group = "preview" },
				{ "<leader>d", group = "debug/diagnostics" },
				{ "<leader>e", group = "explorer" },
				{ "<leader>f", group = "find/file" },
				{ "<leader>g", group = "git" },
				{ "<leader>gx", group = "conflicts" },
				{ "<leader>o", group = "tasks" },
				{ "<leader>q", group = "quit/session" },
				{ "<leader>r", group = "run/tests" },
				{ "<leader>s", group = "search/history" },
				{ "<leader>t", group = "toggle/terminal" },
				{ "<leader>u", group = "ui" },
				{ "<leader>w", group = "window" },
				{ "<leader>x", group = "diagnostics/quickfix" },
				{ "<leader>z", group = "zen mode" },
				{ "<leader><Tab>", group = "tab" },
			})
		end,

		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
