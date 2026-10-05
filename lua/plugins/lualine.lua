local buffer_mode = 1

local function setup_lualine()
	require("lualine").setup({
		options = {
			globalstatus = true,
		},
		sections = {
			lualine_c = {
				{
					"buffers",
					mode = buffer_mode,
					max_length = function()
						return math.floor(vim.o.columns * 0.6)
					end,
					symbols = {
						modified = " ●",
						alternate_file = "",
						directory = "",
					},
				},
			},
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = setup_lualine,
	keys = {
		{
			"<leader>be",
			function()
				buffer_mode = buffer_mode == 1 and 2 or 1
				setup_lualine()
				vim.notify(buffer_mode == 1 and "Buffer names collapsed" or "Buffer names expanded")
			end,
			desc = "Expand/collapse buffer names",
		},
	},
}
