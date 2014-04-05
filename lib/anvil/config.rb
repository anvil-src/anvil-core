# encoding: UTF-8

require 'mixlib/config'
require 'anvil/config/class_methods'
require 'gem_ext/mixlib'

module Anvil
  # Configuration management
  module Config
    extend Mixlib::Config
    extend Anvil::Config::ClassMethods

    config_context :github do
      configurable :user
      configurable :token
    end
  end
end
