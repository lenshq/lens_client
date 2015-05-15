require 'rspec'
require 'lens'

Dir[File.expand_path('../../spec/support/**/*.rb', __FILE__)].each {|f| require f}

RSpec.configure do |c|
  c.mock_with :rspec
  c.color = true
  c.run_all_when_everything_filtered = true
end
