return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local health = require("dotfiles.health")

		local configured_linters = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			nix = { "statix" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			lua = { "luacheck" },
			python = { "ruff" },
			java = { "checkstyle" },
			kotlin = { "ktlint" },
		}
		local linter_commands = {
			eslint_d = "eslint_d",
			statix = "statix",
			shellcheck = "shellcheck",
			luacheck = "luacheck",
			ruff = "ruff",
			checkstyle = "checkstyle",
			ktlint = "ktlint",
		}

		lint.linters_by_ft = {}
		for filetype, linters in pairs(configured_linters) do
			local available = vim.tbl_filter(function(name)
				return health.has(linter_commands[name])
			end, linters)
			if #available > 0 then
				lint.linters_by_ft[filetype] = available
			end
		end

		local timers = {}
		local lint_group = vim.api.nvim_create_augroup("UserLint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
			group = lint_group,
			callback = function(event)
				local bufnr = event.buf
				local timer = timers[bufnr]
				if not timer then
					timer = vim.uv.new_timer()
					timers[bufnr] = timer
				end
				timer:stop()
				timer:start(100, 0, vim.schedule_wrap(function()
					if not vim.api.nvim_buf_is_valid(bufnr) or not vim.api.nvim_buf_is_loaded(bufnr) then
						return
					end
					if not lint.linters_by_ft[vim.bo[bufnr].filetype] then
						return
					end
					vim.api.nvim_buf_call(bufnr, lint.try_lint)
				end))
			end,
		})
		vim.api.nvim_create_autocmd("BufWipeout", {
			group = lint_group,
			callback = function(event)
				local timer = timers[event.buf]
				if timer then
					timer:stop()
					timer:close()
					timers[event.buf] = nil
				end
			end,
		})
	end,
}
