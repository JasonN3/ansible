# Settings Configurations on Client Machines
This is done using Puppet. A git repository should be configured to store the code. This will provide you with a log of who changed the configuration and when. Syncing the repository can be done using R10k.

**ALL** machine configurations should be stored in your configuration management tool of choice even if you choose not to use Puppet. This can function as both your change tracking and your documentation.

## Advantages of Puppet
- Gurantee that changes will be applied within 30 minutes of the Puppet master getting the changes. This can scale to 200,000+ nodes without that 30 minute window changing.
- All configurations are verified every 30 minutes  
  There will always be a rogue admin in your network at some point (even if you are a team of 1). Verifying the configurations frequently ensures your machines do not have configuration drift.

## Configuring R10k
My preferred method to manage R10k's configuration is to use Puppet itself. This can be accomplished using the [R10k module](https://forge.puppet.com/modules/puppet/r10k)
1) Configure your [Puppetfile](GitRepo.md#puppetfile) to include the r10k module by adding the following line.  
  `mod 'puppet-r10k', '10.3.0'`  
  10.3.0 is the latest version as of writing this, but a newer version may be available. Make sure to check the module's page for the latest version.  
  If you would like to ensure you are always using the latest version of the module, `:latest` can be used instead of `'10.3.0'`.
  
1) Create a [module](GitRepo.md#modules) within your git repo for r10k
1) Within the `manifests/init.pp` file, add the following code. making sure to replace `*yourclass*` with the module's name and configure your git address:
    ```puppet
    class *yourclass* {
      class { 'r10k':
        sources => {
          '*sourcename**' => {
            'remote'  => '*gitrepo*',
            'basedir' => "${::settings::codedir}/environments",
          }
        },
      }
    }
    ```
    `*yourclass*`  = The name of your module  
    `*sourcename*` = A name for the source. This is not used anywhere  
    `*gitrepo*`    = The address to your git repo. This can be done using https, ssh, or an absolute path
4) *Optional* Run `pdk validate` to ensure your module does not have any syntax errors  
   This command will also give formatting recommendations
1) Commit and push your module to your git repo  

The following steps kickstart the normal syncing process  

6) Copy the module to `/etc/puppetlabs/code/modules/` on the Satellite server
1) Load the web interface for the Satellite server and browse to `Configure` -> `Classes` (under Puppet ENC)
1) Click `Import environments from *satellite_server*` at the top right where `*satellite_server*` will be the name of your satellite server
1) Select the class for your r10k module and click `Import`
1) Browse to `Hosts` -> `All Hosts` and click `Edit` under `Actions` for your Satellite server
1) Select the `Puppet ENC` tab and add the r10k class under `Available Classes`. You will need to first click the module and then the class name. It should show up under `Included Classes` once added
1) Once added, click `Submit`
1) SSH to the Satellite server and run `puppet agent -t` twice  
   The first run will configure R10k  
   The second run will run R10k

The puppet agent will automatically run every 30 minutes by default which will pull any updates from your git server at the same time.

## Importing modules
1) Ensure the Puppet modules are synced. This will normally happen every 30 minutes, but can be manually run by running the command `puppet agent -t` on the Satellite server
1) Log in to the Satellite server web interface
1) Browse to `Configure` -> `Classes` under `Puppet ENC` in the menu
1) Click `Import environments from *satellite_server*` at the top right where `*satellite_server*` will be the name of your satellite server
1) Select all of the classes you would like to import and click `Import`
1) If there are no parameters you would like to be able to configure at the Host Group level, you are done
1) Select one of the classes you imported that you need to enable overriding the parameters
1) Switch to the `Smart Class Parameter` tab
1) Select the parameter you would like to override
1) Check the box for `Override`
1) Select any other parameters you would like to override and check the `Override` box for them as well
1) Click `Submit`

You will then be able to override the parameters at multiple locations. Overriding them at the Host Group is normally the most useful, but other locations can be used. While looking at the parameter on the `Smart Class Parameter` tab, you can also change the order of the matchers or create custom match entries for more advanced configurations.

## Assigning configurations
1) Log in to the Satellite server web interface
1) Browse to `Configure` -> `Host Groups` in the menu
1) Select the host group you would like to assign the configuration to
1) Switch to the `Puppet ENC` tab
1) Assign any classes by selecting them under `Available Classes`  
   Any classes assigned will be inherited by all child groups and hosts
1) Parameters for classes can be modified switching to the `Parameters` 

## Config Groups
When you need to ensure the same classes are assigned to multiple host groups, `Config Groups` can be used. They group classes together so the group can be assigned to a `Host Group`
1) Log in to the Satellite server web interface
1) Browse to `Configure` -> `Config Groups`
1) Click `Create Config Group`
1) Name it something that makes sense (remember, this is your note to your future self and others)
1) Add any classes you need assigned
1) Click `Submit`