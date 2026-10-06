return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	opts = {
		preset = "modern",
		transparent_bg = true,
		transparent_cursorline = true,
		options = {
			show_source = {
				enabled = true,
				if_many = true,
			},
			show_code = true,
			multilines = {
				enabled = true,
				always_show = false,
				severity = { vim.diagnostic.severity.ERROR },
			},
			show_all_diags_on_cursorline = true,
			overflow = {
				mode = "wrap",
				padding = 1,
			},
			virt_texts = {
				priority = 2048,
			},
		},
	},
	config = function(_, opts)
		require("tiny-inline-diagnostic").setup(opts)
		vim.diagnostic.config({ virtual_text = false })
	end,
}
