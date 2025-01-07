local config = function()
  local telescope = require("telescope")
  telescope.setup({
		defaults = {
			file_ignore_patterns = { "node_modules", ".venv", ".git/" },
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		extensions = {
			"fzf",
		},
	})
	telescope.load_extension("fzf")
end

return {
	"nvim-telescope/telescope.nvim",
  lazy = false,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	keys = function()
    local builtin = require('telescope.builtin')
    return {
      {'<leader>pf', builtin.find_files, desc="Find All Files"},
      {'<leader>ps', builtin.live_grep, desc="Grep Files"},
      {'<leader>pr', builtin.lsp_references, desc="Lsp References"},
      {'<leader>pp', builtin.resume, desc="Resume"},
      {'<leader>pb', builtin.buffers, desc="Buffers"},
    }
  end,
	config = config,
}
