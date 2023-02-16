# Machine Provisioning
There a few choices to get everything started, but the processes have fairly similar dependencies
## Configuring PXE with DHCP Options
Configure your DHCP server with the following options. Option 67 should return different values depending on the `user-class`. Most DHCP servers can handle conditional return values.
| Option Name | Option Number | Description |
| --- | --- | --- |
| next-server | 66 | Set to the TFTP server that hosts iPXE's boot file. This can be the Satellite server or another server |
| filename | 67 | Initially set to the boot file on the TFTP server. <br /> When `user-class = "iPXE"`, it should return the iPXE script. By default this is `http://*satellite_server*:8000/unattended/iPXE` |

## Downloading the boot disk for PXE without DHCP Options
1) Log in to the web interface of the Satellite server
1) Browse to `Infrastructure` -> `Subnets`
1) On the row for one of your subnets, click the arrow down **next to** `Delete` and select `Subnet generic image`  
The `Subnet generic image` will contain iPXE with a script to override the DHCP options required for PXE booting.  
The only subnet specific information stored in the image is the `Template Capsule` as that is used when downloading the template files. As long as you are using the same `Template Capsule`, you can use the image on multiple subnets

## Deploying a host
1) Log in to the web interface of your Satellite server
1) Browse to `Hosts` -> `Create Host` on the menu
1) Enter the machine name and 