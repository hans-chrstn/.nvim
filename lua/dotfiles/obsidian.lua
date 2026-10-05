local M = {}

M.workspaces = {
	{ name = "Personal", path = "~/Documents/Obsidian/Personal" },
	{ name = "Work", path = "~/Documents/Obsidian/Work" },
}

local function contains(path, root)
	path = vim.fs.normalize(vim.fn.expand(path))
	root = vim.fs.normalize(vim.fn.expand(root))
	return path == root or vim.startswith(path, root .. "/")
end

function M.is_vault(bufnr)
	local path = vim.api.nvim_buf_get_name(bufnr)
	if path == "" then
		return false
	end

	for _, workspace in ipairs(M.workspaces) do
		if contains(path, workspace.path) then
			return true
		end
	end

	return vim.fs.root(bufnr, ".obsidian") ~= nil
end

return M
