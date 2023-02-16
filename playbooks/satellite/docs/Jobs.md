# Jobs
Jobs can be used to accomplish tasks remotely. Satellite supports jobs written in either Bash or Ansible. I would recommend you write them in Ansible. Because Ansible is [idempotent](https://en.wikipedia.org/wiki/Idempotence), you don't need to worry about running it multiple times against the same machine and is less likely to cause an issue with your machines. The version of Ansible built in to Satellite does have some limitations but is a good starting point. As your usage of Ansible expands, you may want to look in to [AAP](https://www.redhat.com/en/technologies/management/ansible). Satellite and AAP can share information so actions are taken on AAP while the inventory is stored in Satellite.

## Advantages of Ansible
- Coordination between multiple nodes/devices
  This can allow you to take a node out of load-balancer pool during maintenance, reconfigure a switch port, or send notifications to other devices or people while an action is being taken
- Idempotent processing allows the playbook to be run multiple times without worry about changing the result. Instead of writing that logic in to a script, it will already be there