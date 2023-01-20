# Install RH Satellite
## Steps
1. Install ansible-core. All other requirements will be installed as part of run.sh
1. Copy inventory.example.ini to inventory.ini and fill out the inventory file with the infrastructure information  
   Group Information:
   - satellite (required): This should contain 1 server that will host the Satellite server.
   - capsule (optional): This should contain the Capsule servers.
   - testclient (optional): If specified, tests will be run from these servers to ensure communication back to the Satellite/Capsule servers. Override the variable "capsule_server" to specify the test should target a Capsule server instead of the Satellite server.
1. Copy `configure.example.yaml` to `configure.yaml` and configure your information
   - Items within REQUIRED are required in order for the installation to complete and the features to function
   - Items within RECOMMENDED are recommended in order to utilize more of Satellite's features
   - Items within OPTIONAL are items that can be customized to your needs but are not needed for the initial configuration
1. Run `run.sh`  
   Any addition arguments will be passed to `ansible-playbook`

## Tags used in playbook
- `access-rh`: Verify that the Satellite server can reach the required RH internet addresses
- `access-repos`: Verify that the Satellite server can reach the additional repos
- `manifest`: Adds the subscription manifest to Satellite
- `reposets`: Enables the recommended repo sets
- `syncplan`: Create a daily sync plan
- `sync`: Sync all enabled repos
- `verify-os`: Verifies that a valid OS is running on the Satellite and Capsule servers
- `subscribe-sat`: Subscribes the Satellite server to RH
- `sat-repos`: Enables the Satellite repos during the Satellite server installation
- `update`: Update all packages during the installation
- `compute`: Enable compute resources
- `custom-certificate`: Configure custom certificate
- `useful-featuress`: Enable features considered useful
- `additional-features`: Enable configured additional features
- `install-satellite`: Run the Satellite installer