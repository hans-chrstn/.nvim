return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			ui = {
				border = "none",
				devicon = true,
				title = true,
				expand = "",
				collapse = "",
				code_action = "",
				actionfix = "",
				lines = { "┗", "┣", "┃", "━", "┏" },
				kind = {},
				imp_sign = "󰳛 ",
			},
			lightbulb = {
				enable = false,
				sign = false,
				virtual_text = false,
			},
			code_action = {
				num_shortcut = true,
				show_server_name = true,
				keys = {
					quit = "<Esc>",
					exec = "<CR>",
				},
			},
			diagnostic = {
				on_insert = false,
				on_insert_follow = false,
				insert_winblend = 0,
				show_code_action = false,
				show_source = true,
				jump_num_shortcut = true,
				max_width = 0.7,
				custom_fix = nil,
				custom_msg = nil,
				text_hl_follow = false,
				border_follow = true,
				keys = {
					exec_action = "o",
					quit = "q",
				},
			},
			hover = {
				max_width = 0.6,
				open_link = "gx",
				open_browser = "!chromium",
			},
			rename = {
				quit = "<Esc>",
				exec = "<CR>",
				mark = "x",
				confirm = "<CR>",
				in_select = true,
				whole_project = true,
			},
			symbol_in_winbar = {
				enable = true,
				separator = " › ",
			},
			finder = {
				max_height = 0.5,
				min_width = 30,
				force_max_height = false,
				keys = {
					jump_to = "p",
					expand_or_jump = "o",
					vsplit = "s",
					split = "i",
					tabe = "t",
					tabnew = "r",
					quit = { "q", "<ESC>" },
					close_in_preview = "<ESC>",
				},
			},
			definition = {
				edit = "<C-c>o",
				vsplit = "<C-c>v",
				split = "<C-c>i",
				tabe = "<C-c>t",
				quit = "q",
			},
			outline = {
				win_position = "right",
				win_with = "",
				win_width = 30,
				show_detail = true,
				auto_preview = true,
				auto_refresh = true,
				auto_close = true,
				custom_sort = nil,
				keys = {
					jump = "o",
					expand_collapse = "u",
					quit = "q",
				},
			},
			callhierarchy = {
				show_detail = false,
				keys = {
					edit = "e",
					vsplit = "s",
					split = "i",
					tabe = "t",
					jump = "o",
					quit = "q",
					expand_collapse = "u",
				},
			},
			beacon = {
				enable = true,
				frequency = 7,
			},
			implement = {
				enable = false,
				sign = true,
				lang = {},
				virtual_text = true,
				priority = 100,
			},
		},
		keys = {
			{ "gh", "<cmd>Lspsaga finder<CR>", desc = "LSP Finder" },
			{
				"<leader>ca",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "Code Action",
			},
			{ "gp", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
			{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to Definition" },
			{ "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Line Diagnostics" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
			{ "<leader>o", "<cmd>Lspsaga outline<CR>", desc = "Toggle Outline" },
			{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Hover Documentation" },
		},
	},

	{
		"dundalek/lazy-lsp.nvim",
		commit = "ccaaed19d7963bdc06000052eade993452b7ad86",
		dependencies = {
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return {
				use_vim_lsp_config = true,
				excluded_servers = {
					"jdtls",
					"ccls",
					"buf_ls",
					--"clangd",
					"sourcekit",
					"intelliphense",
					"flow", -- prefer eslint and ts_ls
					"ltex", -- grammar tool using too much CPU
					"quick_lint_js", -- prefer eslint and ts_ls
					"denols",
					"oxlint", -- prefer eslint
					"scry", -- archived on Jun 1, 2023
				},
				preferred_servers = {
					markdown = {},
					python = { "pyright" },
					rust = { "rust_analyzer" },
					javascript = { "ts_ls" },
					typescript = { "ts_ls" },
					lua = { "lua_ls" },
					nix = { "nil_ls" },
					c = { "clangd" },
					cpp = { "clangd" },
					go = { "gopls" },
				},
			}
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			"dundalek/lazy-lsp.nvim",
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					prefix = "●",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✘",
						[vim.diagnostic.severity.WARN] = "▲",
						[vim.diagnostic.severity.HINT] = "⚑",
						[vim.diagnostic.severity.INFO] = "»",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "none",
					source = "always",
					header = "Diagnostics:",
					prefix = "  ",
					suffix = "  ",
					format = function(diagnostic)
						return " " .. diagnostic.message .. " "
					end,
					max_width = 80,
					max_height = 20,
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
					end

					map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
					map("n", "gs", vim.lsp.buf.signature_help, "Signature Help")

					if client and client:supports_method("textDocument/documentHighlight") then
						local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = bufnr,
							group = hl_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = bufnr,
							group = hl_group,
							callback = vim.lsp.buf.clear_references,
						})
					end

					if client and client:supports_method("textDocument/inlayHint") then
						map("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
						end, "Toggle Inlay Hints")
					end
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "gd", "gdscript", "gdscript3" },
				callback = function()
					local root = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, {
						path = vim.api.nvim_buf_get_name(0),
						upward = true,
					})[1])

					if root then
						vim.lsp.start({
							name = "Godot",
							cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
							root_dir = root,
							capabilities = capabilities,
							on_attach = function()
								vim.notify("Godot LSP connected!", vim.log.levels.INFO)
							end,
						})
					end
				end,
			})
		end,
	},
}
