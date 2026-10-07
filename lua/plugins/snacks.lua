return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			styles = {
				terminal = {
					wo = {
						winhighlight = "Normal:Normal,NormalNC:NormalNC,NormalFloat:Normal",
						winbar = "",
					},
				},
			},
			bigfile = {
				enabled = true,
				notify = true,
				size = 1024 * 1024,
				setup = function(ctx)
					vim.b.minianimate_disable = true
					vim.schedule(function()
						vim.bo[ctx.buf].syntax = ctx.ft
					end)
				end,
			},
			-- Initial Tree-sitter parsing is deferred until after the first screen.
			quickfile = { enabled = false },
			words = {
				enabled = true,
				debounce = 100,
			},
			gitbrowse = {
				enabled = true,
				notify = true,
			},
			lazygit = { enabled = true },
			terminal = { enabled = true },
			rename = { enabled = true },
			bufdelete = { enabled = true },
			indent = { enabled = false },
			input = { enabled = true },
			explorer = { enabled = true, trash = true },
			zen = {
				enabled = true,
				toggles = {
					dim = true,
					git_signs = false,
					mini_diff_signs = false,
					diagnostics = false,
					inlay_hints = false,
				},
				zoom = {
					width = 120,
				},
			},
			statuscolumn = {
				enabled = false,
				left = { "mark" },
				right = { "fold", "git" },
				folds = {
					open = false,
					git_hl = false,
				},
				git = {
					patterns = { "GitSign", "MiniDiffSign" },
				},
			},
			dashboard = {
				enabled = true,
				pane_gap = 2,
				preset = {
					header = [[
╔────────────────────────────────────────────────────────────────────╗
│                                                                    │
│  ███▄ ▄███▓ ▄▄▄      ▓█████▄ ▓█████  ██▓     ██▓ ███▄    █ ▓█████  │
│ ▓██▒▀█▀ ██▒▒████▄    ▒██▀ ██▌▓█   ▀ ▓██▒    ▓██▒ ██ ▀█   █ ▓█   ▀  │
│ ▓██    ▓██░▒██  ▀█▄  ░██   █▌▒███   ▒██░    ▒██▒▓██  ▀█ ██▒▒███    │
│ ▒██    ▒██ ░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄ ▒██░    ░██░▓██▒  ▐▌██▒▒▓█  ▄  │
│ ▒██▒   ░██▒ ▓█   ▓██▒░▒████▓ ░▒████▒░██████▒░██░▒██░   ▓██░░▒████▒ │
│ ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░░ ▒░▓  ░░▓  ░ ▒░   ▒ ▒ ░░ ▒░ ░ │
│ ░  ░      ░  ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░░ ░ ▒  ░ ▒ ░░ ░░   ░ ▒░ ░ ░  ░ │
│ ░      ░     ░   ▒    ░ ░  ░    ░     ░ ░    ▒ ░   ░   ░ ░    ░    │
│        ░         ░  ░   ░       ░  ░    ░  ░ ░           ░    ░  ░ │
│                       ░                                            │
│                                                                    │
╚────────────────────────────────────────────────────────────────────╝]],
				},
				formats = {
					key = function(item)
						return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
					end,
				},
				sections = {
					{ section = "header" },
					{
						padding = 1,
						text = {
							{ "󰭎 ", hl = "SnacksDashboardIcon" },
							{ "[f] ", hl = "SnacksDashboardKey" },
							{ "Search  ", hl = "SnacksDashboardDesc" },
							{ "󰍉 ", hl = "SnacksDashboardIcon" },
							{ "[l] ", hl = "SnacksDashboardKey" },
							{ "Word Search  ", hl = "SnacksDashboardDesc" },
							{ " ", hl = "SnacksDashboardIcon" },
							{ "[o] ", hl = "SnacksDashboardKey" },
							{ "Recent Files  ", hl = "SnacksDashboardDesc" },
							{ " ", hl = "SnacksDashboardIcon" },
							{ "[n] ", hl = "SnacksDashboardKey" },
							{ "New File  ", hl = "SnacksDashboardDesc" },
							{ "󰩈 ", hl = "SnacksDashboardIcon" },
							{ "[q] ", hl = "SnacksDashboardKey" },
							{ " Exit", hl = "SnacksDashboardDesc" },
						},
						align = "center",
					},
					{
						hidden = true,
						key = "f",
						action = function()
							Snacks.picker.files()
						end,
					},
					{
						hidden = true,
						key = "l",
						action = function()
							Snacks.picker.grep()
						end,
					},
					{
						hidden = true,
						key = "o",
						action = function()
							Snacks.picker.recent()
						end,
					},
					{
						hidden = true,
						key = "n",
						action = function()
							local filename = vim.fn.input("Enter filename: ")
							if filename ~= "" then
								vim.cmd("edit " .. filename)
							else
								print("Filename cannot be empty")
							end
						end,
					},
					{ hidden = true, key = "q", action = ":qa" },
					{
						icon = "",
						title = "Recently Used:",
						section = "recent_files",
						limit = 10,
						cwd = false,
						indent = 2,
						padding = 1,
					},
					{
						icon = "",
						title = "Projects:",
						section = "projects",
						limit = 8,
						indent = 2,
						padding = 1,
					},
				},
			},
			notifier = { enabled = true, timeout = 3000 },
			scroll = { enabled = false },
			picker = {
				enabled = true,
				sources = {
					files = { hidden = true },
					explorer = {
						follow_file = false,
						layout = { preset = "sidebar", preview = false },
						win = {
							list = {
								wo = {
									winhighlight = table.concat({
										"Normal:Normal",
										"NormalNC:NormalNC",
										"NormalFloat:Normal",
										"FloatBorder:FloatBorder",
										"FloatTitle:FloatTitle",
										"FloatFooter:FloatFooter",
										"CursorLine:SnacksPickerListCursorLine",
									}, ","),
								},
								keys = {
									e = "toggle_maximize",
								},
							},
						},
					},
				},
			},
			scope = { enabled = false },
			scratch = { enabled = true },
			animate = { enabled = false },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				once = true,
				callback = function()
					require("snacks.indent").enable()
				end,
			})
		end,
		keys = {
			{
				"<leader>ss",
				function()
					Snacks.scratch()
				end,
				desc = "Open scratch buffer",
			},
			{
				"<leader>sS",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select scratch buffer",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo history",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "Open Snacks Explorer",
			},
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>gb",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Open in GitHub/GitLab",
			},
			{
				"<leader>gB",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>rn",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File (LSP-aware)",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					Snacks.bufdelete.all()
				end,
				desc = "Delete All Buffers",
			},
			{
				"<leader>bo",
				function()
					Snacks.bufdelete.other()
				end,
				desc = "Delete Other Buffers",
			},
			{
				"]r",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Word Reference",
			},
			{
				"[r",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Previous Word Reference",
			},
			{
				"<leader>gg",
				function()
					if vim.fn.executable("lazygit") ~= 1 then
						vim.notify("lazygit is not available in Neovim's PATH. Run :checkhealth dotfiles", vim.log.levels.WARN)
						return
					end
					Snacks.lazygit()
				end,
				desc = "LazyGit",
			},
			{
				"<leader>tt",
				function()
					Snacks.terminal.toggle()
				end,
				desc = "Toggle Terminal (Split)",
			},
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart find files",
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command history",
			},
			{
				"<leader>b",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<C-p>",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Search Git files",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume picker",
			},
			{
				"<leader>gc",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git commits",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git status",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help pages",
			},
			{
				"<leader>sa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Autocommands",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer lines",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command history",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>sD",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Workspace diagnostics",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer diagnostics",
			},
			{
				"<leader>sH",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Highlight groups",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.man()
				end,
				desc = "Man pages",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sR",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume picker",
			},
			{
				"<leader>uC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss notifications",
			},
		},
	},
}
