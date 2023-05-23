## Kickstart in Azure

Using Kickstart in Azure gives you a way to utilize all of your existing on-prem processes in the Cloud. However, you can't directly boot an ISO. Instead you need to convert it to a VHD. Here are the steps to convert the bootdisk Satellite creates in to a VHD that you can then use in Azure.

These tasks need to be completed on a Windows machine

First, get the ISO we need to clone
1. Launch a web browse and log in to your Satellite server
1. Browse to the subnets section (Infrastructure -> Subnets)
1. On the far right of one of your subnets, click the arrow down next to `Delete` and click `Subnet generic image`  
    This image will contain the PXE information required to deploy any VM. If you use any Capsule servers, make sure you select a subnet that has the same `HTTPBoot Capsule`. Even though the image is labeled subnet specific, the only information contained is the satellite/capsule server url.  

Next, download GParted so we can clone the ISO to the "disk"
1. Download [GParted](https://downloads.sourceforge.net/gparted/gparted-live-1.5.0-1-amd64.iso)

Next, we'll create the virtual "disk" that we'll later upload to Azure. This cannot be done while creating the VM because that will create a VHDX and Azure needs a VHD
1. Launch Disk Management  
    This can be done by clicking start and typing in `diskmgmt.msc`. As you are typing it, you may see `Create and format hard disk partitions`. That is just a different name for the same application. Click on that or `diskmgmt.msc`.
1. Select `Action` on the menu bar and then click `Create VHD`
1. Use `Browse` to select a location to save the VHD
1. Enter `3MB` as the size
1. Make sure that `VHD` is selected. VHDX is not supported in Azure
1. Make sure the disk type is `Fixed size`
1. Click OK
1. Right click on the new disk and click `Detach VHD`  

Next, create the VM that will clone the ISO to the "disk"
1. Launch Hyper-V. If you don't have it installed, please follow [these instructions](https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v)
1. Right click on your machine and click `New` -> `Virtual Machine...`
1. Click `Next` to get past the `Before your Begin` page
1. Give your VM a name
1. Click `Next`
1. Leave the Virtual machine set to `Generation 1`
1. Click `Next`
1. Click `Next` without changing the memory
1. Click `Next` without setting a connection
1. Select `Use an existing virtual hard disk` and select the VHD we created earlier
1. Click `Next` and then `Finish`. It may take a little while for the VM to create
1. Right click on the new VM you created and select `Settings`
1. Select the `DVD Drive` and then select GParted ISO you downloaded earlier
1. Click on `IDE Controller 1`, select `DVD Drive`, and then click `Add` to add a second DVD Drive
1. On the new `DVD Drive`, select the boot disk you downloaded earlier from the Satellite server
1. Click `OK`
1. Right click on the VM and click `Connect`
1. Click `Start`
1. Press `Enter` to boot GParted with the default settings
1. Press `Enter` to select `Don't touch keymap`
1. Press `Enter` to select `US English`
1. Press `2` and then `Enter` to select `Enter command line prompt`
1. Run `lsblk` and verify that you see `sda` with a size of `10M` and `sr1`. `sr1` is the second DVD drive which is where we mounted boot disk. `sda` is the first hard drive, which is where the VHD is mounted. If the drives are labeled differently for you, make sure to adjust the command in the next step.
1. Run `dd if=/dev/sr1 of=/dev/sda status=progress` to copy the boot disk to the VHD. The command should complete quickly.
1. You can now shut down the VM by clicking `Action` in the menu bar and then `Turn Off...`
1. Once the VM is off you can then upload the VHD to Azure using [Add-AzVHD](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/disks-upload-vhd-to-managed-disk-powershell#use-add-azvhd) or [AzCopy](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/disks-upload-vhd-to-managed-disk-powershell#manual-upload) or [Azure Storage Explorer](https://learn.microsoft.com/en-us/azure/vs-azure-tools-storage-manage-with-storage-explorer?tabs=windows)

Now that we have a VHD that can boot to Satellite, lets configure Satellite to know what to do with an unknown machine  

First, change the default boot option from `local` to `discovery`

**WARNING** This is a global setting. Any machines that PXE boot from the Satellite server without being registered to Satellite will boot in to discovery. Make sure that PXE is either removed from the boot order or is below the local disk. Machines that Satellite is aware of will exit PXE by default unless build mode is enabled for that host.

1. Launch a web browse and log in to your Satellite server
1. Go to Settings by hovering over `Administer` and selecting `Settings`
1. Select the `Provisioning` tab
1. Edit the value for `Default PXE global template entry` and set it to `discovery`
1. On the Satellite server, install foreman-discovery-image using `satellite-maintain packages install foreman-discovery-image`
1. On the Satellite server, run `discovery-iso-to-pxe /usr/share/foreman-discovery-image/foreman-discovery-image-3.8.2-1.iso` to convert the discovery ISO to PXE. The version of the ISO may change as new version of Satellite are released. Even though it will create a tftpboot directory in the current directory, it will copy the files you need in to the right location.

You can now use the uploaded VHD as your source image when creating a new VM. When the VM boots, it will request a DHCP lease, override the options related to PXE, PXE boot from the Satellite server, boot the discover image, and then it will wait for you to provision the host. Provisioning can be done from Hosts -> Discovered Hosts within the Satellite Web UI. Once the host is provisioned, the VM will reboot and start the installation. During the installation, it will format the disk and replace it with the selected OS. You can also automate the provisioning process using [Discovery Rules](https://access.redhat.com/documentation/en-us/red_hat_satellite/6.13/html/provisioning_hosts/configuring_the_discovery_service_provisioning#Creating_Discovery_Rules_provisioning)
