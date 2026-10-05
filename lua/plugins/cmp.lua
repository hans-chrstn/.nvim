local function has_vulkan_umbrella(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return false
	end

	local last_line = math.min(vim.api.nvim_buf_line_count(bufnr), 500)
	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, last_line, false)) do
		local header = line:match('^%s*#%s*include%s*[<"]([^>"]+)[>"]')
		if header == "vulkan.h" or header == "vulkan/vulkan.h" then
			return true
		end
	end

	return false
end

local function filter_clangd_includes(ctx, items)
	if not vim.tbl_contains({ "c", "cpp" }, vim.bo[ctx.bufnr].filetype) or not has_vulkan_umbrella(ctx.bufnr) then
		return items
	end

	for _, item in ipairs(items) do
		if item.client_name == "clangd" and item.additionalTextEdits then
			item.additionalTextEdits = vim.tbl_filter(function(edit)
				return not (type(edit.newText) == "string" and edit.newText:find("vulkan_core%.h"))
			end, item.additionalTextEdits)
		end
	end

	return items
end

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
					lsp = {
						transform_items = filter_clangd_includes,
					},
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
