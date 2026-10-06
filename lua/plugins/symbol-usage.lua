local function toggle_symbol_usage()
	local symbol_usage = require("symbol-usage")
	local enabled = symbol_usage.toggle_globally()
	vim.g.symbol_usage_enabled = enabled

	if enabled then
		vim.schedule(symbol_usage.refresh)
	end

	vim.notify("Symbol usage annotations " .. (enabled and "enabled" or "disabled"))
end

return {
	"Wansmer/symbol-usage.nvim",
	event = "LspAttach",
	config = function()
		local SymbolKind = vim.lsp.protocol.SymbolKind
		local symbol_usage = require("symbol-usage")

		symbol_usage.setup({
			hl = { link = "Comment" },
			kinds = { SymbolKind.Function, SymbolKind.Method },
			vt_position = "above",
			request_pending_text = false,
			references = {
				enabled = true,
				include_declaration = false,
			},
			definition = { enabled = false },
			implementation = { enabled = false },
			log = { enabled = false },
		})

		if vim.g.symbol_usage_initialized ~= true then
			symbol_usage.toggle_globally()
			vim.g.symbol_usage_enabled = false
			vim.g.symbol_usage_initialized = true
		end
	end,
	keys = {
		{
			"<leader>cu",
			toggle_symbol_usage,
			desc = "Toggle symbol usage annotations",
		},
	},
}
