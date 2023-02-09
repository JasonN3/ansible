# Host Groups
These should be structured similar to how you would structure an AD infrastructure  
While creating a host group for each lifecycle step is optional, it is recommended. When created, all hosts can inherit information from the group and be more easily moved around if necessary.

## Recommended Layout
- General - This group will be used to apply configurations to all machines
  - Domain - This group will be a parent of all machines that will be domain joined. It is recommended that all machines are domain joined, but exceptions sometimes have to be made
    - Department1 - This level is where you will create a group for each department. This level is for organization so you know which department needs to be imformed if something happens to one of the servers
      - Group1 - This level is where you can create groups of servers (web servers, database servers, etc) so you can group configurations
        - Department1-Group1-Dev - This is the level where you will assign machines. The long name makes it easier to create search bookmarks. The lifecycle step being included in the name allows you to set everything at the group level and ensure nothing is set at the machine level.
  - Non-Domain - This group will be a parent of all machines that will not be domain joined. It is recommended to not need this group, but if you do, it's an option
    - Department1 - This level is where you will create a group for each department. This level is for organization so you know which department needs to be imformed if something happens to one of the servers
      - Group1 - This level is where you can create groups of servers (web servers, database servers, etc) so you can group configurations
        - Department1-Group1-Dev - This is the level where you will assign machines. The long name makes it easier to create search bookmarks. The lifecycle step being included in the name allows you to set everything at the group level and ensure nothing is set at the machine level.

If you are utlizing both the Domain and Non-Domain groups, you can ensure the configurations applied to the child groups are the same by using [Config Groups](Configurations.md#config-groups)