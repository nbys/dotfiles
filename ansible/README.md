# Ansible playbook for my tools

This playbook installs my tools on a fresh Fedora Workstation, Ubuntu, Amazon
Linux, or macOS machine. Fedora has dedicated `Fedora.yml` task files; Amazon
Linux continues to use the existing `RedHat.yml` tasks. Debian and macOS keep
their existing platform tasks unchanged.

On Fedora the playbook also installs Ghostty, Zed, and Iosevka Nerd Font, makes
Zsh the login shell, adds the user to the Docker group, and links the project
configuration into `~/.config`.
The Zsh role also installs Oh My Zsh and the plugins used by the checked-in
configuration. It links `~/.zshenv` when that path is free, but preserves an
existing regular file rather than overwriting it.

To install only Zsh and its configuration dependencies, run:

```bash
ansible-playbook playbook.yaml --tags zsh -K
```

## Fedora Workstation

On a clean installation:

```bash
sudo dnf install -y ansible-core git
mkdir -p ~/Projects
git clone https://github.com/nbys/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles/ansible
ansible-playbook playbook.yaml -K
```

Log out and back in after the first run so the new login shell and Docker group
membership take effect.

Fedora uses native packages where available. Docker and Terraform use their
official Fedora repositories. Ghostty uses the community COPR referenced by
Ghostty's Fedora installation documentation, while Zed uses its official
per-user installer.

## macOS

Install Ansible, clone this repository into `~/.config`, and run the playbook:

```bash
cd ~/.config/ansible
ansible-playbook playbook.yaml -K
```

The Docker role installs Docker Desktop. After the first run, open Docker from
Applications once to accept its terms and finish the privileged setup.

To refresh Homebrew metadata, upgrade installed Homebrew packages when any are
outdated, and install missing build dependencies, run:

```bash
ansible-playbook playbook.yaml --tags deps -K
```

## Updating tool versions

Pinned versions live in each role's `vars/main.yml`. Change the value and run
only that role; Ansible compares the installed version, updates it when needed,
and verifies the result. For example:

```bash
# Edit roles/neovim/vars/main.yml, then:
ansible-playbook playbook.yaml --tags neovim -K
```

The version-aware roles are:

- `node` (`nodejs_version` is a major release such as `26`)
- `rust` (`rust_version`)
- `go` (`go_version`)
- `python` (`python_version`)
- `neovim` (`neovim_version`, including the leading `v`)
- `k8s` (`kubectl_version`, including the leading `v`)
- `terraform` (`terraform_version`)
- `fish` (`fish_version`, when the role is enabled)
- `erlang` (`erlang_version`, when the role is enabled)

For package-manager installations, the configured repository must already offer
the requested version. The role fails its final version check if Homebrew, APT,
or DNF has not caught up yet, rather than silently leaving a different version
installed.

## Tests and development

Start a container with the following command:

```bash
# execute from the root of the repository
docker build -f ansible/tests/Dockerfile.ubuntu -t ansible-ubuntu .
docker run --rm -it ansible-ubuntu:latest

# Fedora
docker build -f ansible/tests/Dockerfile.fedora -t ansible-fedora .
docker run --rm -it ansible-fedora:latest

# amazon linux
docker build -f ansible/tests/Dockerfile.amazonlinux -t ansible-amazon .
docker run --rm -it ansible-amazon:latest 
```

While in the container, run the following command to test the playbook:
```bash
ansible-playbook playbook.yaml -K
```
