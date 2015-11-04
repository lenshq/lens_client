if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'rspec'
require 'rails'
require 'lens'

Dir[File.expand_path('../../spec/support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.after :each do
    Lens.stop
    Lens.configuration = nil
  end

  config.mock_with :rspec
  config.color = true
  config.run_all_when_everything_filtered = true

  config.include Helpers

  config.profile_examples = 3
  config.order = :random
  Kernel.srand config.seed
end
