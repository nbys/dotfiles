local parsers = {
  "bash",
  "css",
  "dockerfile",
  "erlang",
  "gitignore",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "rust",
  "solidity",
  "svelte",
  "toml",
  "typescript",
  "vue",
  "yaml",
  "cds",
}

local highlighted_filetypes = {
  "cds",
  "css",
  "dockerfile",
  "erlang",
  "gitignore",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "rust",
  "sh",
  "solidity",
  "svelte",
  "toml",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

local function register_cds_parser()
  require("nvim-treesitter.parsers").cds = {
    install_info = {
      url = "https://github.com/SAP-archive/tree-sitter-cds.git",
      branch = "main",
      files = { "src/parser.c", "src/scanner.c" },
      queries = "nvim",
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  init = function()
    local group = vim.api.nvim_create_augroup("CustomTreeSitterParsers", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "TSUpdate",
      callback = register_cds_parser,
    })
  end,
  config = function()
    local treesitter = require("nvim-treesitter")

    register_cds_parser()
    vim.treesitter.language.register("cds", "cds")

    treesitter.setup({})
    treesitter.install(parsers)

    local group = vim.api.nvim_create_augroup("TreeSitterHighlighting", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = highlighted_filetypes,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
