local enabled = false
local dropbar_winbar = "%{%v:lua.dropbar()%}"

local function set_enabled(value)
	enabled = value
	local bar = require("dropbar.utils").bar

	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		if enabled then
			bar.attach(vim.api.nvim_win_get_buf(winid), winid)
		elseif vim.wo[winid].winbar == dropbar_winbar then
			vim.wo[winid].winbar = ""
		end
	end
end

return {
	"Bekaboo/dropbar.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local default_enable = require("dropbar.configs").opts.bar.enable
		require("dropbar").setup({
			bar = {
				enable = function(bufnr, winid, info)
					return enabled and default_enable(bufnr, winid, info)
				end,
			},
		})
		set_enabled(false)
	end,
	keys = {
		{
			"<leader>ub",
			function()
				set_enabled(not enabled)
				vim.notify("Breadcrumbs " .. (enabled and "shown" or "hidden"))
			end,
			desc = "Toggle breadcrumbs",
		},
		{
			"<leader>;",
			function()
				require("dropbar.api").pick()
			end,
			desc = "Pick breadcrumb",
		},
		{
			"[;",
			function()
				require("dropbar.api").goto_context_start()
			end,
			desc = "Go to context start",
		},
		{
			"];",
			function()
				require("dropbar.api").select_next_context()
			end,
			desc = "Select next context",
		},
	},
}
