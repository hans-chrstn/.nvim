local function fold(command)
	return function()
		vim.cmd("normal! " .. command)
	end
end

return {
	"chrisgrieser/nvim-origami",
	keys = {
		{ "za", fold("za"), desc = "Toggle fold" },
		{ "zo", fold("zo"), desc = "Open fold" },
		{ "zc", fold("zc"), desc = "Close fold" },
		{ "zR", fold("zR"), desc = "Open all folds" },
		{ "zM", fold("zM"), desc = "Close all folds" },
		{ "zj", fold("zj"), desc = "Next fold" },
		{ "zk", fold("zk"), desc = "Previous fold" },
	},
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
	opts = {
		useLspFoldsWithTreesitterFallback = {
			enabled = true,
			foldmethodIfNeitherIsAvailable = "indent",
		},
		pauseFoldsOnSearch = true,
		foldtext = {
			enabled = true,
			diagnosticsCount = true,
			gitsignsCount = true,
		},
		autoFold = {
			enabled = false,
		},
		foldKeymaps = {
			setup = false,
		},
	},
}
