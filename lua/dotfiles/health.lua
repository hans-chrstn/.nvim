local M = {}
local nix_lsp = require("dotfiles.nix_lsp")

local sections = {
	{
		name = "Core tools",
		tools = {
			{ "git", "plugin installation and Git features", true },
			{ "rg", "project search and todo-comments" },
			{ "fd", "fast file discovery" },
			{ "tree-sitter", "Tree-sitter parser installation and updates" },
		},
	},
	{
		name = "C and C++",
		tools = {
			{ "clangd", "language server", true, "clangd" },
			{ "clang-format", "formatting and indentation settings", true },
			{ "codelldb", "debug adapter" },
			{ "cc", "C compiler" },
			{ "c++", "C++ compiler" },
		},
	},
	{
		name = "Language servers",
		tools = {
			{ "lua-language-server", "Lua", false, "lua_ls" },
			{ "pyright-langserver", "Python", false, "pyright" },
			{ "rust-analyzer", "Rust", false, "rust_analyzer" },
			{ "typescript-language-server", "JavaScript and TypeScript", false, "ts_ls" },
			{ "jdtls", "Java", false, "jdtls" },
			{ "nixd", "Nix", false, "nixd" },
			{ "gopls", "Go", false, "gopls" },
			{ "marksman", "Markdown", false, "marksman" },
			{ "glsl_analyzer", "GLSL shaders", false, "glsl_analyzer" },
			{ "slangd", "Slang and HLSL shaders", false, "slangd" },
			{ "neocmakelsp", "CMake", false, "neocmake" },
		},
	},
	{
		name = "Formatters",
		tools = {
			{ "stylua", "Lua" },
			{ "black", "Python" },
			{ "prettier", "web and Markdown files" },
			{ "rustfmt", "Rust" },
			{ "alejandra", "Nix" },
			{ "google-java-format", "Java" },
		},
	},
	{
		name = "Linters",
		tools = {
			{ "eslint_d", "JavaScript and TypeScript" },
			{ "statix", "Nix" },
			{ "shellcheck", "shell scripts" },
			{ "luacheck", "Lua" },
			{ "ruff", "Python" },
			{ "checkstyle", "Java" },
			{ "ktlint", "Kotlin" },
		},
	},
	{
		name = "Optional integrations",
		tools = {
			{ "lazygit", "Git interface" },
			{ "fzf", "native quickfix filtering" },
			{ "mmdc", "Mermaid rendering" },
			{ "magick", "image previews" },
			{ "gs", "PDF previews" },
		},
	},
}

function M.has(command)
	return type(command) == "string" and command ~= "" and vim.fn.executable(command) == 1
end

function M.missing(commands)
	return vim.tbl_filter(function(command)
		return not M.has(command)
	end, commands)
end

function M.check()
	vim.health.start("Neovim")
	if vim.fn.has("nvim-0.12") == 1 then
		vim.health.ok("Neovim 0.12 or newer")
	else
		vim.health.error("Neovim 0.12 or newer is required")
	end
	if pcall(require, "lazy") then
		vim.health.ok("lazy.nvim is available")
	else
		vim.health.error("lazy.nvim is unavailable (it should be provided by Home Manager)")
	end

	for _, section in ipairs(sections) do
		vim.health.start(section.name)
		for _, tool in ipairs(section.tools) do
			local command, purpose, required, managed_server = unpack(tool)
			local path = vim.fn.exepath(command)
			if path ~= "" then
				vim.health.ok(("`%s` available: %s"):format(command, path))
			elseif managed_server and nix_lsp.status(managed_server) == "nix" then
				vim.health.ok(("`%s` available on demand through `nix shell`"):format(command))
			elseif required then
				vim.health.error(("`%s` is missing (%s)"):format(command, purpose))
			else
				vim.health.warn(("`%s` is missing (%s)"):format(command, purpose))
			end
		end
	end

	vim.health.start("Clipboard")
	local clipboard = { "wl-copy", "xclip", "xsel" }
	local available = vim.tbl_filter(M.has, clipboard)
	if #available > 0 then
		vim.health.ok("clipboard provider available: " .. table.concat(available, ", "))
	else
		vim.health.warn("no clipboard provider found (`wl-copy`, `xclip`, or `xsel`)")
	end
end

function M.setup()
	local warned = false
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("DotfilesCppHealth", { clear = true }),
		pattern = { "c", "cpp" },
		callback = function()
			if warned then
				return
			end

			local missing = M.missing({ "clang-format" })
			if nix_lsp.status("clangd") == "unavailable" then
				missing[#missing + 1] = "clangd"
			end
			if #missing == 0 then
				return
			end

			warned = true
			vim.schedule(function()
				vim.notify(
					"Missing C/C++ tools: " .. table.concat(missing, ", ") .. ". Run :checkhealth dotfiles",
					vim.log.levels.WARN
				)
			end)
		end,
	})
end

return M
