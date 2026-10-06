local mode_highlights = {
	"NormalMode",
	"InsertMode",
	"VisualMode",
	"CommandMode",
	"ReplaceMode",
	"SelectMode",
	"TerminalMode",
	"TerminalNormalMode",
}

local function clear_mode_backgrounds()
	for _, name in ipairs(mode_highlights) do
		local highlight = vim.api.nvim_get_hl(0, { name = name, link = false })
		if not vim.tbl_isempty(highlight) then
			highlight.bg = nil
			vim.api.nvim_set_hl(0, name, highlight)
		end
	end

	local cursor_line_number = vim.api.nvim_get_hl(0, { name = "CursorLineNr", link = false })
	cursor_line_number.bg = nil
	vim.api.nvim_set_hl(0, "CursorLineNr", cursor_line_number)
end

return {
	"mawkler/modicator.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lualine/lualine.nvim" },
	init = function()
		vim.opt.cursorline = true
		vim.opt.cursorlineopt = "number"
	end,
	opts = {
		show_warnings = false,
		highlights = {
			defaults = {
				bold = true,
				italic = false,
			},
			use_cursorline_background = false,
		},
		integration = {
			lualine = {
				enabled = true,
				mode_section = "a",
				highlight = "fg",
			},
		},
	},
	config = function(_, opts)
		require("modicator").setup(opts)
		clear_mode_backgrounds()

		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("UserModicatorTransparency", { clear = true }),
			callback = function()
				vim.schedule(clear_mode_backgrounds)
			end,
		})
	end,
}
