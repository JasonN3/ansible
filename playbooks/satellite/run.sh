#!/bin/bash

set -ex

mkdir -p ./collections/ansible_collections
ansible-galaxy collection install -r requirements.yaml --collections-path ./collections/ansible_collections
ansible-playbook main.yaml $@