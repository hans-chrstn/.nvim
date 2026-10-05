local function open_yazi(argument)
	if vim.fn.executable("yazi") ~= 1 then
		vim.notify("yazi is not available in Neovim's PATH. Run :checkhealth dotfiles", vim.log.levels.WARN)
		return
	end

	vim.cmd("Yazi" .. (argument and " " .. argument or ""))
end

return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>e",
			function()
				open_yazi()
			end,
			desc = "Open yazi at the current file",
		},
		{
			"<leader>cw",
			function()
				open_yazi("cwd")
			end,
			desc = "Open yazi at the current working directory",
		},
		{
			"<c-up>",
			function()
				open_yazi("toggle")
			end,
			desc = "Resume the last yazi session",
		},
	},
	opts = {
		open_for_directories = true,
		enable_mouse_support = true,
		floating_window_scaling_factor = 0.8,
		yazi_floating_window_border = "single",
		yazi_floating_window_winblend = 10,
		keymaps = {
			show_help = "<F1>",
			open_file_in_vertical_split = "<C-v>",
			open_file_in_horizontal_split = "<C-x>",
			open_file_in_tab = "<C-t>",
			cycle_open_buffers = "<Tab>",
			copy_relative_path_to_selected_files = "<C-y>",
			send_to_quickfix_list = "<C-q>",
			change_working_directory = "<C-\\>",
			open_and_pick_window = "<C-o>",
		},
	},
}
