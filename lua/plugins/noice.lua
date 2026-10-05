return {
	{
		"folke/noice.nvim",
		event = "VimEnter",
		priority = 50,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			notify = {
				enabled = false,
			},
			messages = {
				enabled = true,
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				message = {
					enabled = true,
				},
				progress = {
					enabled = false,
					view = "mini",
				},
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			format = {
				filter = {
					pattern = {
						":%s*%%s*s:%s*",
						":%s*%%s*s!%s*",
						":%s*%%s*s/%s*",
						"%s*s:%s*",
						":%s*s!%s*",
						":%s*s/%s*",
					},
					icon = "",
					lang = "regex",
				},
				replace = {
					pattern = {
						":%s*%%s*s:%w*:%s*",
						":%s*%%s*s!%w*!%s*",
						":%s*%%s*s/%w*/%s*",
						"%s*s:%w*:%s*",
						":%s*s!%w*!%s*",
						":%s*s/%w*/%s*",
					},
					icon = "󱞪",
					lang = "regex",
				},
			},
		},
	},
}
