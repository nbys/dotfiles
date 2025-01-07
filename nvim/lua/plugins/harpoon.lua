return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = false,
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	},
	keys = function()
		local keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon File",
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon Quick Menu",
			},
			{
				"<C-h>",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(1)
				end,
				desc = "Harpoon Select (1)",
			},
			{
				"<C-t>",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(2)
				end,
				desc = "Harpoon Select (2)",
			},
			{
				"<C-n>",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(3)
				end,
				desc = "Harpoon Select (3)",
			},
			{
				"<C-s>",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(4)
				end,
				desc = "Harpoon Select (4)",
			},
		}
		return keys
	end,
}
