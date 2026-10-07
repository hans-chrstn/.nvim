return {
	"chrisgrieser/nvim-spider",
	keys = {
		{ "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" }, desc = "Next subword" },
		{ "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" }, desc = "End of subword" },
		{ "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" }, desc = "Previous subword" },
		{ "ge", "<cmd>lua require('spider').motion('ge')<cr>", mode = { "n", "o", "x" }, desc = "End of previous subword" },
	},
	opts = {
		skipInsignificantPunctuation = true,
		subwordMovement = true,
	},
}
