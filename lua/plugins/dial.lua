return {
	"monaqa/dial.nvim",
	keys = {
		{ "<C-a>", "<Plug>(dial-increment)", mode = { "n", "x" }, desc = "Increment value" },
		{ "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "x" }, desc = "Decrement value" },
		{ "g<C-a>", "<Plug>(dial-g-increment)", mode = { "n", "x" }, desc = "Increment values sequentially" },
		{ "g<C-x>", "<Plug>(dial-g-decrement)", mode = { "n", "x" }, desc = "Decrement values sequentially" },
	},
	config = function()
		local augend = require("dial.augend")

		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal_int,
				augend.integer.alias.hex,
				augend.integer.alias.octal,
				augend.integer.alias.binary,
				augend.date.alias["%Y/%m/%d"],
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%m/%d/%Y"],
				augend.date.alias["%H:%M"],
				augend.constant.alias.bool,
				augend.constant.alias.Bool,
				augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
				augend.semver.alias.semver,
				augend.hexcolor.new({ case = "prefer_lower" }),
			},
		})
	end,
}
