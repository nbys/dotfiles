local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('config.globals')
require('config.options')
require('config.remap')
require('config.autocmds')

local opts = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { 'rose-pine' }
	},
	rtp = {
		disabled_plugins = {
			"gzip",
        		"matchit",
        		"matchparen",
        		"netrwPlugin",
        		"tarPlugin",
        		"tohtml",
        		"tutor",
        		"zipPlugin",
		}
	},
	change_detection = {
	-- automatically check for config file changes and reload the ui
    		--enabled = true,
    		notify = true, -- get a notification when changes are found
  },
}

require("lazy").setup('plugins', opts)
