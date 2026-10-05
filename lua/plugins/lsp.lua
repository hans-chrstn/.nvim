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
			local obsidian = require("dotfiles.obsidian")

			vim.diagnostic.config({
				virtual_text = { spacing = 4, prefix = "●" },
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
					map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
					map("n", "K", function()
						vim.lsp.buf.hover({ border = "none", max_width = 80, max_height = 20 })
					end, "Hover documentation")
					map("n", "gK", function()
						vim.lsp.buf.signature_help({ border = "none", max_width = 80 })
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

			local dotfiles = vim.fn.expand("~/.dotfiles")
			local servers = {
				pyright = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							files = { exclude = { ".direnv", ".git", "target" } },
						},
					},
				},
				ts_ls = {},
				jdtls = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim", "Snacks" } },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				},
				nixd = {
					settings = {
						nixd = {
							nixpkgs = { expr = 'import (builtins.getFlake "' .. dotfiles .. '").inputs.nixpkgs { }' },
							options = {
								nixos = { expr = '(builtins.getFlake "' .. dotfiles .. '").nixosConfigurations.jin.options' },
								["home-manager"] = {
									expr = '(builtins.getFlake "'
										.. dotfiles
										.. '").nixosConfigurations.jin.options.home-manager.users.type.getSubOptions []',
								},
							},
						},
					},
				},
				clangd = {
					cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
				},
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
			local server_commands = {
				pyright = "pyright-langserver",
				rust_analyzer = "rust-analyzer",
				ts_ls = "typescript-language-server",
				jdtls = "jdtls",
				lua_ls = "lua-language-server",
				nixd = "nixd",
				clangd = "clangd",
				gopls = "gopls",
				marksman = "marksman",
			}

			vim.lsp.config("*", { capabilities = capabilities })
			for name, config in pairs(servers) do
				vim.lsp.config(name, config)
				if health.has(server_commands[name]) then
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
