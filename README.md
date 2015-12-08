[![Build Status](https://travis-ci.org/lenshq/lens_client.svg?branch=master)](https://travis-ci.org/lenshq/lens_client)
[![Code Climate](https://codeclimate.com/github/lenshq/lens_client/badges/gpa.svg)](https://codeclimate.com/github/lenshq/lens_client)
[![Test Coverage](https://codeclimate.com/github/lenshq/lens_client/badges/coverage.svg)](https://codeclimate.com/github/lenshq/lens_client/coverage)

# Lens ruby gem

### Installation

Add to your Gemfile

```ruby
gem 'lens', '~> 0.0.9'
```

or, if you want bleeding edge,

```ruby
gem 'lens', github: 'lenshq/lens_client'
```

### Configuration

* Get your application key at [LensHQ site](http://lenshq.io)
* Create file `config/initializers/lens.rb`
* Configure Lens client (sample config below)
* Start sending your data to Lens =]

```ruby
# config/initializers/lens.rb
Lens.configure do |config|
  config.app_key = 'super_secret_key'
end
```

if you want to use Lens server at your instance
```ruby
# config/initializers/lens.rb
Lens.configure do |config|
  config.app_key = 'super_secret_key'
  config.protocol = 'http'
  config.host = 'localhost'
  config.port = 3001
end
```

If you want to see information about memory allocations - you should enable this functionality:
```ruby
# config/initializers/lens.rb
Lens.configure do |config|
  # ...
  config.show_memory_usage = true
  # ...
end
```
