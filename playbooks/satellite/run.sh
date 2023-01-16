#!/bin/bash

set -ex

ansibleversion=$(ansible --version | grep 'python version' | cut -d= -f2 | awk '{print $1}' | cut -d. -f1,2)

pip${ansibleversion} install jmespath

mkdir -p ./collections/ansible_collections
ansible-galaxy collection install -r requirements.yaml --collections-path ./collections/ansible_collections
ansible-playbook main.yaml $@
