# Satellite Server

## System Requirements
The latest requirements are available at: [System Requirements](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.11/html/installing_satellite_server_in_a_connected_network_environment/preparing_your_environment_for_installation_satellite)

- x86_64 architecture
- 4-core 2.0 GHz CPU at a minimum
- 20 GB RAM
- RHEL 8
- Hostname configured to FQDN
- Forward (A) and reverse (PTR) DNS records

## Recommended
- Install /var to a separate filesystem
  - /var/pulp is where Pulp where store the downloaded packages. This directory can expand quickly while syncing repositories or, if on-demand is used, when a client requests a package.
- If logs are critical to your environment, put /var/log on a separate filesystem.
  - If /var is undersized, it can fill up and prevent logs from being written
- /var should be at least 100GiB and using XFS