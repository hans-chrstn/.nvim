local function project_root()
	return vim.fs.root(0, { "compile_commands.json", "CMakeLists.txt", "Makefile", ".git" }) or vim.fn.getcwd()
end

local function executable()
	return vim.fn.input("Path to executable: ", project_root() .. "/", "file")
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"igorlfs/nvim-dap-view",
			opts = {
				auto_toggle = true,
				follow_tab = true,
				windows = {
					size = 0.25,
					position = "below",
				},
				virtual_text = {
					enabled = true,
					position = "inline",
				},
			},
		},
	},
	cmd = {
		"DapContinue",
		"DapNew",
		"DapRestartFrame",
		"DapSetLogLevel",
		"DapShowLog",
		"DapStepInto",
		"DapStepOut",
		"DapStepOver",
		"DapTerminate",
		"DapToggleBreakpoint",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/continue",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step out",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Conditional breakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Start/continue debugging",
		},
		{
			"<leader>dl",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			desc = "Set log point",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle debug REPL",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate debugging",
		},
		{
			"<leader>du",
			"<cmd>DapViewToggle<cr>",
			desc = "Toggle debug UI",
		},
		{
			"<leader>dh",
			":DapViewHover<cr>",
			mode = { "n", "x" },
			desc = "Inspect expression",
		},
		{
			"<leader>dw",
			":DapViewWatch<cr>",
			mode = { "n", "x" },
			desc = "Watch expression",
		},
	},
	config = function()
		local dap = require("dap")
		local adapter = vim.fn.exepath("codelldb")

		if adapter == "" then
			vim.notify("codelldb is not available in Neovim's PATH", vim.log.levels.WARN)
			return
		end

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = adapter,
				args = { "--port", "${port}" },
			},
		}

		local configurations = {
			{
				name = "Launch executable",
				type = "codelldb",
				request = "launch",
				program = executable,
				cwd = project_root,
				stopOnEntry = false,
			},
			{
				name = "Attach to process",
				type = "codelldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				cwd = project_root,
			},
		}

		dap.configurations.c = configurations
		dap.configurations.cpp = configurations
		dap.configurations.rust = configurations
	end,
}
