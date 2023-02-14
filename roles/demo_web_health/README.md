# Demo Web Health

This Ansible role is for demonstrating how Ansible can be used for health checks that can be called during other playbooks.  
This will allow you to verify a service is running and attempt to remediate any problems before (or in addition to) alerting an admin.

## Example Uses
### Part of an update process
First you would assign this role to a host within Satellite.
Then during a playbook that controls the update process, you can run the below code to call all assigned roles.
```yaml
- name: Apply all assigned roles
    include_role:
    name: "{{ role }}"
    loop: "{{ foreman_ansible_roles }}"
    loop_control:
    loop_var: role
```