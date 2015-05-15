require 'rails'

module Lens
  class Railtie < Rails::Railtie
    ActiveSupport::Notifications.subscribe /.*/ do |*args|
      event = ActiveSupport::Notifications::Event.new *args

      puts "\n[LENS] #{args.extract_options!}"
    end
  end
end
