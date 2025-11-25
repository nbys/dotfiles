local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.icons").diagnostic_signs
local typescript_organise_imports = require("util.lsp").typescript_organise_imports

local config = function()
	require("neoconf").setup({})
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- helper for roots (new API)
	local function root_with(markers)
		return function(fname)
			return vim.fs.root(fname, markers)
		end
	end

	local sev = vim.diagnostic.severity
	local ds = require("util.icons").diagnostic_signs -- e.g. { Error="", Warn="", Hint="", Info="" }

	vim.diagnostic.config({
		signs = {
			-- set the text shown in the sign column per severity
			text = {
				[sev.ERROR] = ds.Error,
				[sev.WARN] = ds.Warn,
				[sev.HINT] = ds.Hint,
				[sev.INFO] = ds.Info,
			},
			-- optional:
			-- numhl = {
			--   [sev.ERROR] = "DiagnosticSignError",
			--   [sev.WARN]  = "DiagnosticSignWarn",
			--   [sev.HINT]  = "DiagnosticSignHint",
			--   [sev.INFO]  = "DiagnosticSignInfo",
			-- },
		},
		-- while you’re here, you can keep the rest consistent:
		virtual_text = true,
		underline = true,
		update_in_insert = false,
	})

	-- Lua
	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
					checkThirdParty = false,
				},
			},
		},
	})

	-- Python
	vim.lsp.config("pyright", {
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = { disableOrganizeImports = false },
			python = {
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- Go
	vim.lsp.config("gopls", {
		capabilities = capabilities,
		on_attach = on_attach,
		root_dir = root_with({ "go.mod", ".git" }),
		settings = {
			gopls = {
				gofumpt = true,
				staticcheck = true,
				analyses = { unusedparams = true, shadow = true },
				hints = { parameterNames = true, rangeVariableTypes = true },
			},
		},
	})

	-- golangci-lint-langserver
	vim.lsp.config("golangci_lint_ls", {
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "golangci-lint-langserver" },
		root_dir = root_with({ "go.mod", ".git" }),
		init_options = {
			command = {
				"golangci-lint",
				"run",
				"--enable-all",
				"--disable",
				"lll",
				"--out-format",
				"json",
				"--issues-exit-code=1",
			},
		},
	})

	-- Rust
	vim.lsp.config("rust_analyzer", {
		capabilities = capabilities,
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			if client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ timeout_ms = 100 })
					end,
				})
			end
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end,
		settings = {
			["rust-analyzer"] = {
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
				},
			},
		},
	})

	-- TypeScript / JavaScript
	vim.lsp.config("ts_ls", {
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
		commands = { TypeScriptOrganizeImports = typescript_organise_imports },
		settings = { typescript = { indentStyle = "space", indentSize = 2 } },
		root_dir = root_with({ "package.json", "tsconfig.json", ".git" }),
	})

	-- SAP CDS (adjust server name if yours differs)
	vim.lsp.config("cds_lsp", {
		on_attach = on_attach,
		capabilities = capabilities,
	})

	-- Docker
	vim.lsp.config("dockerls", {
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "dockerfile" },
	})

	-- C/C++
	vim.lsp.config("clangd", {
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "clangd", "--offset-encoding=utf-16" },
	})

	-- Erlang
	vim.lsp.config("erlangls", {
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "erlang" },
	})

	-- EFM aggregator
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local gofmt = require("efmls-configs.formatters.gofmt")
	local goimports = require("efmls-configs.formatters.goimports")
	local eslint = require("efmls-configs.linters.eslint")
	local prettier = require("efmls-configs.formatters.prettier")
	local cpplint = require("efmls-configs.linters.cpplint")
	local clangformat = require("efmls-configs.formatters.clang_format")
	local ruff_linter = require("efmls-configs.linters.ruff")
	local ruff_formatter = require("efmls-configs.formatters.ruff")
	local mypy = require("efmls-configs.linters.mypy")

	vim.lsp.config("efm", {
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"lua",
			"python",
			"go",
			"rust",
			"javascript",
			"typescript",
			"typescriptreact",
			"vue",
			"dockerfile",
			"c",
			"cpp",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { ruff_linter, ruff_formatter, mypy },
				go = { gofmt, goimports },
				typescript = { eslint, prettier },
				javascript = { eslint, prettier },
				typescriptreact = { eslint, prettier },
				vue = { eslint, prettier },
				dockerfile = { prettier },
				c = { clangformat, cpplint },
				cpp = { clangformat, cpplint },
			},
		},
	})

	-- finally enable all at once
	vim.lsp.enable({
		"lua_ls",
		"pyright",
		"gopls",
		"golangci_lint_ls",
		"rust_analyzer",
		"ts_ls",
		"cds_lsp",
		"dockerls",
		"clangd",
		"erlangls",
		"efm",
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
