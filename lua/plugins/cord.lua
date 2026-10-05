return {
	"vyfor/cord.nvim",
	cond = function()
		return vim.env.NVIM_ENABLE_CORD == "1"
	end,
	event = "VeryLazy",
	keys = {
		{
			"<leader>Ct",
			function()
				require("cord.api.command").toggle_presence()
			end,
			desc = "Toggle Discord presence",
		},
		{
			"<leader>Ci",
			function()
				require("cord.api.command").toggle_idle_force()
			end,
			desc = "Toggle Discord idle status",
		},
	},
	opts = {
		log_level = "error",
		editor = {
			image = nil,
			client = "neovim",
			tooltip = "Neovim",
		},
		idle = {
			show_status = true,
			timeout = 300000,
			tooltip = "Idle",
		},
		text = { editing = "Working in Neovim", viewing = "Working in Neovim" },
		buttons = nil,
	},
}
