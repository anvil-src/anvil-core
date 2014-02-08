require 'mixlib/config'
require 'alfred/config/class_methods'

module Alfred
  module Config
    extend Mixlib::Config
    extend Alfred::Config::ClassMethods

    config_context :github do
      configurable :user
      configurable :token
    end
  end
end
