# Ansible playbook for my tools

This playbook installs my tools on a fresh Ubuntu, Amazon Linux, or macOS
machine. On macOS it supports both Apple Silicon and Intel and uses Homebrew
for native packages. Homebrew is installed automatically when it is missing.
The Zsh role also installs Oh My Zsh and the plugins used by the checked-in
configuration. It links `~/.zshenv` when that path is free, but preserves an
existing regular file rather than overwriting it.

To install only Zsh and its configuration dependencies, run:

```bash
ansible-playbook playbook.yaml --tags zsh -K
```

## macOS

Install Ansible, clone this repository into `~/.config`, and run the playbook:

```bash
cd ~/.config/ansible
ansible-playbook playbook.yaml -K
```

The Docker role installs Docker Desktop. After the first run, open Docker from
Applications once to accept its terms and finish the privileged setup.

## Tests and development

Start a container with the following command:

```bash
# execute from the root of the repository
docker build -f ansible/tests/Dockerfile.ubuntu -t ansible-ubuntu .
docker run --rm -it ansible-ubuntu:latest

# amazon linux
docker build -f ansible/tests/Dockerfile.amazonlinux -t ansible-amazon .
docker run --rm -it ansible-amazon:latest 
```

While in the container, run the following command to test the playbook:
```bash
ansible-playbook playbook.yaml -K
```
