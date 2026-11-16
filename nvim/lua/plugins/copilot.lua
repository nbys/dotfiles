return {
	"github/copilot.vim",
	lazy = false,
	init = function()
		-- Keep a single Tab for normal editing; Copilot acceptance is explicit below.
		vim.g.copilot_no_tab_map = true
	end,
	config = function()
		vim.keymap.set("i", "<Tab><Tab>", 'copilot#Accept("")', {
			expr = true,
			replace_keycodes = false,
			silent = true,
			desc = "Accept Copilot suggestion",
		})
	end,
}
