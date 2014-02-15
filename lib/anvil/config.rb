require 'mixlib/config'
require 'anvil/config/class_methods'
require 'gem_ext/mixlib'

module Anvil
  module Config
    extend Mixlib::Config
    extend Anvil::Config::ClassMethods

    config_context :github do
      configurable :user
      configurable :token
    end
  end
end
