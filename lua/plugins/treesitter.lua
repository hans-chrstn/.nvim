local parsers = {
	"bash",
	"c",
	"cpp",
	"css",
	"gdscript",
	"go",
	"html",
	"java",
	"javascript",
	"json",
	"kotlin",
	"lua",
	"markdown",
	"markdown_inline",
	"nix",
	"python",
	"rust",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

local filetype_languages = {
	bash = "bash",
	c = "c",
	cpp = "cpp",
	css = "css",
	gdscript = "gdscript",
	go = "go",
	html = "html",
	java = "java",
	javascript = "javascript",
	javascriptreact = "javascript",
	json = "json",
	kotlin = "kotlin",
	lua = "lua",
	markdown = "markdown",
	nix = "nix",
	python = "python",
	rust = "rust",
	sh = "bash",
	tsx = "tsx",
	typescript = "typescript",
	typescriptreact = "tsx",
	vim = "vim",
	vimdoc = "vimdoc",
	yaml = "yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = function()
			if vim.fn.executable("tree-sitter") ~= 1 then
				error("tree-sitter CLI is missing; run :checkhealth dotfiles")
			end
			require("nvim-treesitter").install(parsers):wait(300000)
		end,
		config = function()
			require("nvim-treesitter").setup({})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
				pattern = vim.tbl_keys(filetype_languages),
				callback = function(event)
					local bufnr = event.buf
					local filetype = vim.bo[bufnr].filetype
					local lang = filetype_languages[filetype]

					vim.schedule(function()
						if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= filetype then
							return
						end
						if pcall(vim.treesitter.start, bufnr, lang) then
							vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
							for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
								vim.wo[winid].foldmethod = "expr"
								vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"
							end
						end
					end)
				end,
			})

			vim.opt.foldenable = false
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")
			local select_maps = {
				aa = "@parameter.outer",
				ia = "@parameter.inner",
				af = "@function.outer",
				["if"] = "@function.inner",
				ac = "@class.outer",
				ic = "@class.inner",
				ii = "@conditional.inner",
				ai = "@conditional.outer",
				il = "@loop.inner",
				al = "@loop.outer",
				at = "@comment.outer",
			}
			for lhs, capture in pairs(select_maps) do
				local textobject = capture
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(textobject, "textobjects")
				end, { desc = "Select " .. textobject })
			end

			local modes = { "n", "x", "o" }
			vim.keymap.set(modes, "]m", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function start" })
			vim.keymap.set(modes, "]]", function()
				move.goto_next_start("@class.outer", "textobjects")
			end, { desc = "Next class start" })
			vim.keymap.set(modes, "]M", function()
				move.goto_next_end("@function.outer", "textobjects")
			end, { desc = "Next function end" })
			vim.keymap.set(modes, "][", function()
				move.goto_next_end("@class.outer", "textobjects")
			end, { desc = "Next class end" })
			vim.keymap.set(modes, "[m", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Previous function start" })
			vim.keymap.set(modes, "[[", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end, { desc = "Previous class start" })
			vim.keymap.set(modes, "[M", function()
				move.goto_previous_end("@function.outer", "textobjects")
			end, { desc = "Previous function end" })
			vim.keymap.set(modes, "[]", function()
				move.goto_previous_end("@class.outer", "textobjects")
			end, { desc = "Previous class end" })
			vim.keymap.set("n", "<leader>a", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap with next parameter" })
			vim.keymap.set("n", "<leader>A", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap with previous parameter" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		opts = { enable = true },
	},

	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascriptreact", "typescriptreact" },
		opts = {},
	},
}
