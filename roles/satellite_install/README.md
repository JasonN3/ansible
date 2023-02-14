## Install Satellite
This role will install a Satellite server on a fresh machine

## Machine Recommendations
- Install /var to a separate partition 
  - minimum of 100GiB of space
  - Partitioned using LVM
  - XFS filesystem
- At least 20GiB of RAM

## Tags
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
