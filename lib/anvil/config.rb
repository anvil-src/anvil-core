# encoding: UTF-8

require 'mixlib/config'
require 'anvil/config/class_methods'
require 'anvil/extensions_manager'
require 'gem_ext/mixlib'

module Anvil
  # Configuration management
  module Config
    extend Mixlib::Config
    extend Anvil::Config::ClassMethods
  end
end
Anvil::ExtensionsManager.load_config_extensions
