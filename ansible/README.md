# Ansible playbook for my tools

This playbook installs my tools on a fresh Ubuntu or AWS Linux machine.

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
