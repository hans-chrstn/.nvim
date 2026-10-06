return {
	"HiPhish/rainbow-delimiters.nvim",
	event = "VeryLazy",
	submodules = false,
	config = function()
		local supported = { c = true, cpp = true, lua = true, nix = true, rust = true }
		local config = require("rainbow-delimiters.config")
		local lib = require("rainbow-delimiters.lib")

		vim.schedule(function()
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(bufnr) and supported[vim.bo[bufnr].filetype] then
					local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
					if config.enabled_for(lang) and config.enabled_when(bufnr) then
						pcall(lib.attach, bufnr)
					end
				end
			end
		end)
	end,
}
