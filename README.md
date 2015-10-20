[![Build Status](https://travis-ci.org/lenshq/lens_client.svg?branch=master)](https://travis-ci.org/lenshq/lens_client)
[![Code Climate](https://codeclimate.com/github/lenshq/lens_client/badges/gpa.svg)](https://codeclimate.com/github/lenshq/lens_client)

# lenshq ruby gem

```ruby
gem 'lens'
```

OR

```ruby
gem 'lens', github: 'lenshq/lens_client'
```

```ruby
#cat config/initializers/lens.rb
Lens.configure { |config| config.app_key = "f0d333a605caa3ec28f344276258b6287bd6ade2e0c94aab6ab2a5cf88f27fcb" }
```

OR

```ruby
#cat config/initializers/lens.rb
Lens.configure do |config|
  config.app_key = "f0d333a605caa3ec28f344276258b6287bd6ade2e0c94aab6ab2a5cf88f27fcb"
  config.protocol = "http"
  config.host = "localhost"
  config.port = 3001
end
```
