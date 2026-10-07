local function neotest()
	return require("neotest")
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"orjangj/neotest-ctest",
	},
	keys = {
		{
			"<leader>rr",
			function()
				neotest().run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>rf",
			function()
				neotest().run.run(vim.api.nvim_buf_get_name(0))
			end,
			desc = "Run test file",
		},
		{
			"<leader>ra",
			function()
				neotest().run.run(vim.fn.getcwd())
			end,
			desc = "Run all tests",
		},
		{
			"<leader>rl",
			function()
				neotest().run.run_last()
			end,
			desc = "Run last test",
		},
		{
			"<leader>rd",
			function()
				neotest().run.run({ strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>rs",
			function()
				neotest().summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"<leader>ro",
			function()
				neotest().output.open({ enter = true, auto_close = true })
			end,
			desc = "Show test output",
		},
		{
			"<leader>rp",
			function()
				neotest().output_panel.toggle()
			end,
			desc = "Toggle test output panel",
		},
		{
			"<leader>rx",
			function()
				neotest().run.stop()
			end,
			desc = "Stop test",
		},
	},
	config = function()
		local namespace = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					return diagnostic.message:gsub("[\r\n\t%s]+", " ")
				end,
			},
		}, namespace)

		require("neotest").setup({
			adapters = {
				require("neotest-ctest").setup({
					dap_adapter = "codelldb",
					is_test_file = function(file)
						if type(file) ~= "string" then
							return false
						end

						local extension = vim.fn.fnamemodify(file, ":e")
						local stem = vim.fn.fnamemodify(file, ":t:r")
						local cpp_extension = extension == "cpp" or extension == "cc" or extension == "cxx"
						return cpp_extension and (vim.endswith(stem, "_test") or vim.endswith(stem, "_tests"))
					end,
				}),
			},
		})
	end,
}
