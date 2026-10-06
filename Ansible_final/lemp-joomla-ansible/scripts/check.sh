#!/usr/bin/env bash
set -euo pipefail

ansible-galaxy collection install -r requirements.yml
ansible-lint playbook.yml
ansible-playbook playbook.yml --syntax-check "$@"
