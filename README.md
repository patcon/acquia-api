# Acapi

Ruby implementation of the Acquia Cloud API.

## Installation

Add this line to your application's Gemfile:

    gem 'acapi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acapi

## Usage

```rb
require 'acapi'

cert = File.read('./cloudapi.acquia.com.pem')

conn = AcquiaCloudAPI::Connection.new('username', 'password', cert)
res = conn.get('/v1/sites/sitename.json')

human_sitename = res.title # "Full subscription title"
production = !!res.production_mode # true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
