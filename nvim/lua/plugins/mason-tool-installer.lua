local opts = {
	ensure_installed = {
		"stylua",
		"prettier",
	},

	run_on_start = true,
}
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
	lazy = false,
}
