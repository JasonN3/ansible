# Patch RHEL system
This playbook is designed to be run from a Satellite server as a job. 

## Steps
1. Take a snapshot of the target VM (if all the necessary information is available)
1. Install all available package updates
1. Apply all assigned Ansible roles (This can be used to verify all services are healthy before continuing)
1. Delete the snapshot that was taken