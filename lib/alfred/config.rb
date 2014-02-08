require 'mixlib/config'
require 'alfred/config/class_methods'

module Alfred
  module Config
    extend Mixlib::Config

    config_context :github do
      configurable :user
      configurable :token
    end

    class << self
      include Alfred::Config::ClassMethods
    end
  end
end
