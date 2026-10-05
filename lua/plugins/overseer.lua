return {
	"stevearc/overseer.nvim",
	cmd = {
		"OverseerClose",
		"OverseerOpen",
		"OverseerRun",
		"OverseerShell",
		"OverseerTaskAction",
		"OverseerToggle",
	},
	keys = {
		{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
		{ "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
		{ "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
		{
			"<leader>ol",
			function()
				local tasks = require("overseer").list_tasks({ recent_first = true })
				if tasks[1] then
					tasks[1]:restart()
				else
					vim.notify("No Overseer task to restart", vim.log.levels.INFO)
				end
			end,
			desc = "Restart last task",
		},
	},
	opts = {
		dap = false,
		task_list = {
			direction = "bottom",
			max_height = { 20, 0.3 },
		},
	},
}
