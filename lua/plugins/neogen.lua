return {
	"danymat/neogen",
	version = "*",
	cmd = "Neogen",
	keys = {
		{
			"<leader>cg",
			function()
				require("neogen").generate()
			end,
			desc = "Generate annotation",
		},
	},
	opts = {
		snippet_engine = "nvim",
		languages = {
			c = {
				template = { annotation_convention = "doxygen" },
			},
			cpp = {
				template = { annotation_convention = "doxygen" },
			},
		},
	},
}
