local opts = {
	ensure_installed = {
		"efm",
		"bashls",
		"lua_ls",
		"pyright",
		"jsonls",
		"ruff",
		"gopls",
		--"solidity",
		--"tailwindcss",
		-- Lua

		--"emmet_ls",
		--"clangd",
	},

	automatic_installation = true,
}
return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
