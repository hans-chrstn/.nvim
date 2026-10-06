local function preview(method)
	return function()
		require("goto-preview")[method]()
	end
end

return {
	"rmagatti/goto-preview",
	dependencies = { "rmagatti/logger.nvim" },
	opts = {
		width = 120,
		height = 20,
		border = "rounded",
		default_mappings = false,
		focus_on_open = true,
		dismiss_on_move = false,
		force_close = true,
		bufhidden = "wipe",
		stack_floating_preview_windows = true,
		same_file_float_preview = true,
		preview_window_title = { enable = true, position = "left" },
		references = { provider = "snacks" },
		vim_ui_input = false,
	},
	keys = {
		{ "<leader>cpd", preview("goto_preview_definition"), desc = "Preview definition" },
		{ "<leader>cpD", preview("goto_preview_declaration"), desc = "Preview declaration" },
		{ "<leader>cpt", preview("goto_preview_type_definition"), desc = "Preview type definition" },
		{ "<leader>cpi", preview("goto_preview_implementation"), desc = "Preview implementation" },
		{ "<leader>cpr", preview("goto_preview_references"), desc = "Preview references" },
		{ "<leader>cpc", preview("close_all_win"), desc = "Close preview windows" },
	},
}
