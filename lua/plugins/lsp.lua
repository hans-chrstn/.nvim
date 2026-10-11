return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local health = require("dotfiles.health")
			local nix_lsp = require("dotfiles.nix_lsp")
			local obsidian = require("dotfiles.obsidian")
			local function clangd_args()
				local args = { "--background-index", "--clang-tidy", "--header-insertion=iwyu" }
				if not health.has("gcc") and not health.has("g++") then
					return args
				end

				local drivers = {}
				for _, executable in ipairs({ "gcc", "g++", "cc", "c++" }) do
					local path = vim.fn.exepath(executable)
					if path ~= "" and not vim.list_contains(drivers, path) then
						drivers[#drivers + 1] = path
					end
				end
				if #drivers > 0 then
					args[#args + 1] = "--query-driver=" .. table.concat(drivers, ",")
				end
				return args
			end

			vim.diagnostic.config({
				virtual_text = false,
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
					border = "rounded",
					source = "always",
					header = "Diagnostics:",
					prefix = "  ",
					suffix = "  ",
					max_width = 80,
					max_height = 20,
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				},
			})

			local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
			local highlight_group = vim.api.nvim_create_augroup("UserLspHighlight", { clear = true })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_group,
				callback = function(event)
					local bufnr = event.buf
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if not client then
						return
					end

					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
					end

					map("n", "gd", function()
						Snacks.picker.lsp_definitions()
					end, "Go to definition")
					map("n", "gD", function()
						Snacks.picker.lsp_declarations()
					end, "Go to declaration")
					map("n", "gi", function()
						Snacks.picker.lsp_implementations()
					end, "Go to implementation")
					map("n", "gy", function()
						Snacks.picker.lsp_type_definitions()
					end, "Go to type definition")
					map("n", "gr", function()
						Snacks.picker.lsp_references()
					end, "References")
					map({ "n", "x" }, "<leader>ca", function()
						require("tiny-code-action").code_action()
					end, "Code action with preview")
					map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
					map("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 20 })
					end, "Hover documentation")
					map("n", "gK", function()
						vim.lsp.buf.signature_help({ border = "rounded", max_width = 80 })
					end, "Signature help")
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Previous diagnostic")
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next diagnostic")
					map("n", "<leader>cd", function()
						vim.diagnostic.open_float({ focus = false })
					end, "Line diagnostics")

					if client:supports_method("textDocument/documentHighlight", bufnr) then
						vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = bufnr })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = bufnr,
							group = highlight_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = bufnr,
							group = highlight_group,
							callback = vim.lsp.buf.clear_references,
						})
					end

					if client:supports_method("textDocument/inlayHint", bufnr) then
						map("n", "<leader>th", function()
							local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
							vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
						end, "Toggle inlay hints")
					end
				end,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = lsp_group,
				callback = function(event)
					vim.lsp.buf.clear_references()
					vim.schedule(function()
						local clients = vim.lsp.get_clients({ bufnr = event.buf, method = "textDocument/documentHighlight" })
						if #clients == 0 then
							vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = event.buf })
						end
					end)
				end,
			})

			local commands = {}
			local function start_rpc(command, dispatchers, config)
				return vim.lsp.rpc.start(command, dispatchers, {
					cwd = config.cmd_cwd,
					env = config.cmd_env,
					detached = config.detached,
				})
			end

			local function managed_command(name, args)
				return nix_lsp.command(name, args)
			end

			for name, spec in pairs(nix_lsp.servers) do
				commands[name] = managed_command(name, spec.args)
			end
			commands.clangd = managed_command("clangd", clangd_args())

			local function typescript_cmd(dispatchers, config)
				local command
				if config.root_dir then
					local project_command = vim.fs.joinpath(config.root_dir, "node_modules", ".bin", "typescript-language-server")
					if vim.fn.executable(project_command) == 1 then
						command = { project_command, "--stdio" }
					end
				end
				command = command or nix_lsp.command("ts_ls")
				return start_rpc(command, dispatchers, config)
			end

			local function jdtls_cmd(dispatchers, config)
				local workspace = vim.fn.stdpath("cache") .. "/jdtls/workspace"
				if config.root_dir then
					workspace = workspace .. "/" .. vim.fn.fnamemodify(config.root_dir, ":p:h:t")
				end

				local args = { "-data", workspace }
				for argument in (vim.env.JDTLS_JVM_ARGS or ""):gmatch("%S+") do
					args[#args + 1] = "--jvm-arg=" .. argument
				end
				local command = nix_lsp.command("jdtls", args)
				return start_rpc(command, dispatchers, config)
			end

			local servers = {
				pyright = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							files = { exclude = { ".direnv", ".git", "target" } },
						},
					},
				},
				ts_ls = { cmd = typescript_cmd },
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim", "Snacks" } },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				},
				nixd = {},
				clangd = {
					cmd = commands.clangd,
				},
				glsl_analyzer = {},
				slangd = {
					settings = {
						slang = {
							inlayHints = {
								deducedTypes = true,
								parameterNames = true,
							},
						},
					},
				},
				neocmake = {},
				jdtls = { cmd = jdtls_cmd },
				gopls = {},
				marksman = {
					root_dir = function(bufnr, on_dir)
						if obsidian.is_vault(bufnr) then
							return
						end
						on_dir(vim.fs.root(bufnr, { ".marksman.toml", ".git" }))
					end,
				},
			}
			vim.lsp.config("*", { capabilities = capabilities })
			for name, config in pairs(servers) do
				if commands[name] then
					config.cmd = config.cmd or commands[name]
					vim.lsp.config(name, config)
					vim.lsp.enable(name)
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = lsp_group,
				pattern = { "gd", "gdscript", "gdscript3" },
				callback = function(event)
					local marker = vim.fs.find({ "project.godot", ".git" }, {
						path = vim.api.nvim_buf_get_name(event.buf),
						upward = true,
					})[1]
					if marker then
						vim.lsp.start({
							name = "Godot",
							cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
							root_dir = vim.fs.dirname(marker),
							capabilities = capabilities,
						})
					end
				end,
			})
		end,
	},
}
