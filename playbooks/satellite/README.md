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
   After Satellite is installed, the tag `satellite-install-installer` may need to be skipped using `--skip-tags satellite-install-installer`
1. Once the installation is complete, log in to the Satellite server's web interface using the admin account (If you did not specify a password, it will be stored in persistent.yaml)
1. Browse to Configure -> Roles (under the Ansible header)
1. Import any roles you may need to the Satellite server

## Tags used in playbook
|Tag|Description|
|---|---|
|satellite-install|Tag for the entire role|
|satellite-install-certificate|Configures the Satellite server to use a custom certificate|
|satellite-install-computeresources|Configures the flags to enable the Compute Resoures features|
|satellite-install-dependencies|Install dependencies for Satellite|
|satellite-install-dependencies-packages|Installs the packages that Satellite requires|
|satellite-install-firewall|Configures the firewall for a Satellite server|
|satellite-install-genpassword|Generates a random password if one is not specified|
|satellite-install-insights|Installs the package that contains the Puppet module to enable RH Insights|
|satellite-install-installer|Runs the installer|
|satellite-install-prereqs|Ensure the pre-reqs are met before running the Satellite installer|
|satellite-install-prereqs-accessrepos|Verified the Satellite server can reach any custom repos defined|
|satellite-install-prereqs-accessrh|Verifies the Satellite server can reach Red Hat's CDN|
|satellite-install-prereqs-dns|Verifies that the forward and reverse DNS records are available or the machine is defined in `/etc/hosts`|
|satellite-install-prereqs-os|Verifies the OS meets Satellite's requirements|
|satellite-install-prereqs-selinux|Verifies and configures SELinux so it is enabled in enforcing or permissive mode|
|satellite-install-prereqs-selinux-reboot|Reboots the Satellite server if the SELinux mode was changed|
|satellite-install-repos|Enables the repos required to install a Satellite server|
|satellite-install-updateall|Updates all packages before running the installer|
|satellite-install-updateall-reboot|Reboots the machine if it is required after updating all packages|
|satellite-install-usefulfeatures|Enables useful features on the Satellite server|
|satellite-configure|Tag for the entire role|
|satellite-configure-ansible|Copies the Ansible roles and playbooks to the Satellite server|
|satellite-configure-ansible-roles|Copies and Imports the Ansible roles to the Satellite server|
|satellite-configure-ansible-playbooks|Copies the Ansible playbooks to the Satellite server|
|satellite-configure-computeresources|Configure the Compute Resources|
|satellite-configure-contentviews|Configures and "Everything" Content View on the Satellite server|
|satellite-configure-hostgroups|Configures the Host Groups on the Satellite server|
|satellite-configure-lifecycles|Configures the Lifecycle steps on the Satellite server|
|satellite-configure-manifest|Imports the manifest to the Satellite server|
|satellite-configure-puppet|Imports the Puppet modules to the Satellite server|
|satellite-configure-reposets|Enables the RHEL repos and creates the custom repos|
|satellite-configure-subnets|Configures the subnets that the Satellite server is aware of|
|satellite-configure-syncplan|Configures a daily sync plan for the repos|
|satellite-configure-syncrepos|Syncs all repos configured on the Satellite server|