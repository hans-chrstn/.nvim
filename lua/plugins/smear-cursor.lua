return {
	"sphamba/smear-cursor.nvim",
	event = "VeryLazy",
	opts = {
		cursor_color = "#d9d1c7",
		stiffness = 0.3,
		trailing_stiffness = 0.1,
		damping = 0.5,
		trailing_exponent = 5,
		never_draw_over_target = true,
		hide_target_hack = true,
		gamma = 1,
	},
}
