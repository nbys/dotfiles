# Neovim

## Installation of CDS tree-sitter parser

```bash
git clone https://github.com/cap-js-community/tree-sitter-cds.git
mkdir -p ~/.local/share/nvim/lazy/nvim-treesitter/queries/cds/
cp tree-sitter-cds/queries/* ~/.local/share/nvim/lazy/nvim-treesitter/queries/cds/
rm -rf tree-sitter-cds
```

## Lua

```bash
brew install efm-langserver
brew install lua
brew install lua-language-server
```

## Node and also for LSP, formatters etc:

```bash
npm i -g eslint
```

## Manually install in neovim

```bash
:MasonToolsInstall
```
