return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" },
	opts = {
		sections = {
			lualine_c = { "" },
		},
	},
}
