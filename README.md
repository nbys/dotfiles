# Dotfiles

## VS Code

Portable VS Code preferences are stored in `vscode/settings.json` and can be
installed on Fedora, Ubuntu, and macOS with:

```bash
cd ~/.config/ansible
ansible-playbook playbook.yaml --tags vscode -K
```

Keep company endpoints, remote hosts, databases, and machine-specific settings
in `vscode/settings.local.json`. It is ignored by Git and overrides the public
settings during installation; use `vscode/settings.local.example.json` as a
starting point.

## Neovim

### Installation of CDS tree-sitter parser

```bash
git clone https://github.com/cap-js-community/tree-sitter-cds.git
mkdir -p ~/.local/share/nvim/lazy/nvim-treesitter/queries/cds/
cp tree-sitter-cds/queries/* ~/.local/share/nvim/lazy/nvim-treesitter/queries/cds/
rm -rf tree-sitter-cds
```

### Lua

```bash
brew install efm-langserver
brew install lua
brew install lua-language-server
```

### Node and also for LSP, formatters etc

```bash
npm i -g eslint
```

### Manually install in Neovim

```bash
:MasonToolsInstall
```
