# Information on configuring your git repo for Puppet

## Branches
Your branch names will become your Puppet environments. I would recommend creating a branch for each of your lifecycle steps (Ex: dev, test, qa, prod). Promoting can then be done using Merge Requests/Pull Requests without deleting the source branch. Your changes can then be deployed to each step indvidually. Additional branches can also be created for test work and assigned to a single machine without affecting other machines.

## File Structure
- [Puppetfile](#puppetfile)
- environment.conf
- hiera.yaml
- [modules](#modules)
  - module1
    - metadata.json
    - manifests
      - init.pp
      - class1.pp
  - module2
    - metadata.json
    - manifests
      - init.pp
      - class1.pp

## Puppetfile
This file should be in the root of your git repo. It will contain a list of modules to download from [Puppet Forge](https://forge.puppet.com) or any other sources
### Downloading from [Puppet Forge](https://forge.puppet.com)
1) Identify the module you would like to use by browsing [Puppet Forge](https://forge.puppet.com)
1) Under the **Start using this module** title, you can copy the line that needs to be added to the Puppetfile.  
   - Adding a version specific module (recommended for stability)  
  ```mod 'puppet-r10k', '10.3.0'```
   - Adding the latest version of a module (recommended to ensure the latest version is used)  
  ```mod 'puppet-r10k', :latest```

## Modules
The modules should be created within a `modules` directory at the root of the git repo.  
Within each module directory, a `metadata.json` is required.  
Example `metadata.json`:  
```json
{
  "name": "author-module",
  "version": "2023.102.10601",
  "author": "author",
  "summary": null,
  "license": "Apache 2.0",
  "source": "",
  "issues_url": null,
  "project_page": null,
  "dependencies": [
    {"version_requirement":">= 5.0.0","name":"puppetlabs-stdlib"}
  ]
}
```
   - `name` must start with `author`'s value
   - A recommended format for `version` is YYYY.1MM.1DD##  
   `YYYY` is the 4 digit year  
   `MM` is the 2 digit month  
   `DD` is the 2 digit day  
   `##` is a 2 digit incremental nuber that can be reset whenever the day changes
   There are 1's before the month and day because each portion of the version number cannot start with a 0

