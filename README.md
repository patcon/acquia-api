# Acquia API gem

Ruby implementation of the Acquia Cloud API.

## Installation

Add this line to your application's Gemfile:

    gem 'acquia-api'

And then execute:

    $ bundle

Or install it yourself as: 

    $ gem install acquia-api

## Example Usage

We're going to assume we're testing a production deploy of tag
`release-34` by deploying to the `test` environment, since we'd want to
do this before running through a similar process on `prod` itself.

```rb
require 'acapi'

# Site/subscription will be auto-detected from credentials.
client = AcquiaCloudAPI::Client.new(
  :username => '39513c57-364a-3d2f-4e6a-654d5a793535',
  :password => 'Vah6ewCG0zn0IiQ8ylLyv8rRFZ2vZyAysOSguHkk1mfl9GQuEK3x'
)

client.add_domain 'staging.example.com', :test
client.copy_files! :prod, :test

# Collect response data from methods for later use.
dbcopy_response = client.copy_database! 'my_database', :prod, :test
deploy_response = client.deploy! 'release-34', :test

# Output status of deploy task for fun.
puts client.task_status deploy_response['id']

# Wait for db copy and deploy tasks to complete.
client.poll_task db_copy_response['id']
client.poll_task deploy_response['id']
```

### Auto-polling methods

If you would rather have certain methods automatically wait for their
respective tasks to complete before moving on, paste this into the top
of your code. (You'll likely want to add more functions than
`:create_database`.)

```rb
require 'acapi'

module AcquiaCloudApi
  class Client

    [
      :create_database!
    ].each do |method|
      alias_method "original_#{method}".to_sym, method.to_sym

      define_method method.to_sym do |*args|
        response = self.send("original_#{method}".to_sym, *args)
        task_id = response['id']
        poll_task(task_id)

        original_reponse = response
      end
    end

  end
end

# Client#create_database will now wait for database creation task to complete.
client.create_database! 'testing123'

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
