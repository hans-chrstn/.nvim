return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	lazy = vim.fn.argv(0, -1) ~= "leetcode.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = { arg = "leetcode.nvim" },
}
