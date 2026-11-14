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

### CDS Tree-sitter parser

The Neovim configuration registers and installs the CDS parser and its queries
automatically through `nvim-treesitter`.

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
