local enabled = true

return {
	"rachartier/tiny-glimmer.nvim",
	event = "VeryLazy",
	priority = 10,
	opts = {
		disable_warnings = true,
		autoreload = true,
		refresh_interval_ms = 16,
		text_change_batch_timeout_ms = 50,
		overwrite = {
			auto_map = true,
			yank = {
				enabled = true,
				default_animation = "fade",
			},
			search = {
				enabled = true,
				default_animation = "pulse",
			},
			paste = {
				enabled = true,
				default_animation = "reverse_fade",
			},
			undo = {
				enabled = true,
				default_animation = "fade",
			},
			redo = {
				enabled = true,
				default_animation = "fade",
			},
		},
		animations = {
			fade = {
				min_duration = 150,
				max_duration = 250,
				easing = "outQuad",
				chars_for_max_duration = 20,
				from_color = "Visual",
				to_color = "Normal",
			},
			reverse_fade = {
				min_duration = 150,
				max_duration = 250,
				easing = "outBack",
				chars_for_max_duration = 20,
				from_color = "Visual",
				to_color = "Normal",
			},
			pulse = {
				min_duration = 180,
				max_duration = 300,
				chars_for_max_duration = 20,
				pulse_count = 1,
				intensity = 1,
				from_color = "IncSearch",
				to_color = "Normal",
			},
		},
		hijack_ft_disabled = {
			"aerial",
			"dap-view",
			"dap-view-repl",
			"dap-view-term",
			"help",
			"lazy",
			"qf",
			"snacks_dashboard",
			"snacks_picker_input",
			"snacks_picker_list",
			"snacks_picker_preview",
			"snacks_terminal",
		},
	},
	keys = {
		{
			"<leader>ug",
			function()
				enabled = not enabled
				local glimmer = require("tiny-glimmer")
				if enabled then
					glimmer.enable()
				else
					glimmer.disable()
				end
				vim.notify("Text animations " .. (enabled and "enabled" or "disabled"))
			end,
			desc = "Toggle text animations",
		},
	},
}
