return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local health = require("dotfiles.health")
		local function sync_clang_indent(bufnr)
			if vim.fn.executable("clang-format") ~= 1 then
				return
			end

			local filetype = vim.bo[bufnr].filetype
			local filename = vim.api.nvim_buf_get_name(bufnr)
			if filename == "" then
				filename = vim.fs.joinpath(vim.fn.getcwd(), "untitled." .. (filetype == "cpp" and "cpp" or "c"))
			end

			vim.system({
				"clang-format",
				"--dump-config",
				"--style=file",
				"--fallback-style=LLVM",
				"--assume-filename=" .. filename,
			}, { text = true }, function(result)
				if result.code ~= 0 then
					return
				end

				local indent_width = tonumber(result.stdout:match("\nIndentWidth:%s*(%d+)"))
				local tab_width = tonumber(result.stdout:match("\nTabWidth:%s*(%d+)"))
				local use_tab = result.stdout:match("\nUseTab:%s*(%S+)")
				if not indent_width then
					return
				end

				vim.schedule(function()
					if not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end
					vim.bo[bufnr].shiftwidth = indent_width
					vim.bo[bufnr].softtabstop = indent_width
					vim.bo[bufnr].tabstop = tab_width or indent_width
					vim.bo[bufnr].expandtab = use_tab == "Never"
				end)
			end)
		end

		local configured_formatters = {
			c = { "clang-format" },
			cpp = { "clang-format" },
			lua = { "stylua" },
			python = { "black" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			rust = { "rustfmt" },
			nix = { "alejandra" },
			java = { "google-java-format" },
		}
		local formatters_by_ft = {}
		for filetype, formatters in pairs(configured_formatters) do
			local available = vim.tbl_filter(health.has, formatters)
			if #available > 0 then
				formatters_by_ft[filetype] = available
			end
		end

		conform.setup({
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 1000, lsp_format = "fallback" }
			end,
			formatters_by_ft = formatters_by_ft,
			formatters = {
				["clang-format"] = {
					prepend_args = { "--style=file", "--fallback-style=LLVM" },
				},
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserClangFormatIndent", { clear = true }),
			pattern = { "c", "cpp" },
			callback = function(event)
				sync_clang_indent(event.buf)
			end,
		})

		vim.api.nvim_create_user_command("FormatToggle", function(args)
			if args.bang then
				vim.b.disable_autoformat = not vim.b.disable_autoformat
				vim.notify("Autoformat " .. (vim.b.disable_autoformat and "disabled" or "enabled") .. " for this buffer")
			else
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				vim.notify("Autoformat " .. (vim.g.disable_autoformat and "disabled" or "enabled") .. " globally")
			end
		end, { desc = "Toggle autoformat-on-save", bang = true })
	end,
	keys = {
		{ "<leader>uf", "<cmd>FormatToggle<cr>", desc = "Toggle format globally" },
		{ "<leader>uF", "<cmd>FormatToggle!<cr>", desc = "Toggle format for buffer" },
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "x" },
			desc = "Format buffer or selection",
		},
	},
}
