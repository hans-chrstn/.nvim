return {
	{
		"xzbdmw/colorful-menu.nvim",
		event = "LspAttach",
		opts = {},
	},
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			snippets = { preset = "default" },
			keymap = {
				preset = "default",
				["<Tab>"] = { "fallback" },
				["<S-Tab>"] = { "fallback" },
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = {
				accept = { auto_brackets = { enabled = true } },
				menu = {
					auto_show = true,
					max_height = 15,
					border = "none",
					scrollbar = true,
					winblend = 0,
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								width = { fill = true, max = 60 },
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = {
						max_height = 20,
						max_width = 80,
						border = "none",
						scrollbar = true,
						winblend = 0,
					},
				},
				ghost_text = { enabled = true },
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			cmdline = {
				enabled = true,
				completion = { ghost_text = { enabled = true } },
			},
			signature = {
				enabled = true,
				window = {
					border = "none",
					max_height = 10,
					max_width = 80,
					scrollbar = true,
					winblend = 0,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
