local M = {}

M.servers = {
	pyright = { package = "pyright", executable = "pyright-langserver", args = { "--stdio" }, language = "Python" },
	rust_analyzer = { package = "rust-analyzer", executable = "rust-analyzer", language = "Rust" },
	ts_ls = {
		package = "typescript-language-server",
		executable = "typescript-language-server",
		args = { "--stdio" },
		language = "JavaScript and TypeScript",
	},
	jdtls = { package = "jdt-language-server", executable = "jdtls", language = "Java" },
	lua_ls = { package = "lua-language-server", executable = "lua-language-server", language = "Lua" },
	nixd = { package = "nixd", executable = "nixd", language = "Nix" },
	clangd = { package = "clang-tools", executable = "clangd", language = "C and C++" },
	gopls = { package = "gopls", executable = "gopls", language = "Go" },
	marksman = { package = "marksman", executable = "marksman", args = { "server" }, language = "Markdown" },
	glsl_analyzer = { package = "glsl_analyzer", executable = "glsl_analyzer", language = "GLSL shaders" },
	slangd = { package = "shader-slang", executable = "slangd", language = "Slang and HLSL shaders" },
	neocmake = { package = "neocmakelsp", executable = "neocmakelsp", args = { "stdio" }, language = "CMake" },
}

local function nix_executable()
	local nix = vim.fn.exepath("nix")
	return nix ~= "" and nix or nil
end

function M.command(name, args)
	local spec = assert(M.servers[name], "unknown managed LSP: " .. name)
	local command_args = args or spec.args or {}
	local local_executable = vim.fn.exepath(spec.executable)
	if local_executable ~= "" then
		return vim.list_extend({ local_executable }, vim.deepcopy(command_args)), "local"
	end

	local nix = nix_executable()
	if not nix then
		return nil, "unavailable"
	end

	local command = {
		nix,
		"shell",
		"nixpkgs#" .. spec.package,
		"--command",
		spec.executable,
	}
	vim.list_extend(command, vim.deepcopy(command_args))
	return command, "nix"
end

function M.status(name)
	local spec = assert(M.servers[name], "unknown managed LSP: " .. name)
	local local_executable = vim.fn.exepath(spec.executable)
	if local_executable ~= "" then
		return "local", local_executable
	end
	if nix_executable() then
		return "nix", spec.package
	end
	return "unavailable"
end

return M
