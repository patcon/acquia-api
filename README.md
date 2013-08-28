Usage
-----

```rb
require 'acapi'

client = AcquiaCloudAPI::Client.new(
  :shortname => 'my_subscription',
  :username => 'myuser',
  :password => 'sekret'
)

client.create_database 'database_name'
client.copy_database! 'database_name', 'from_env', 'to_env'
client.copy_files! 'from_env', 'to_env'
client.deploy! 'git_ref', 'env'
client.add_domain 'to_env', 'domain'
client.task_status 'task_id'
client.tasks
```
