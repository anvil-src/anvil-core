require 'anvil/version'
require 'active_support/core_ext'

module Anvil
  Error = Class.new(StandardError)
end

require 'anvil/config'
require 'anvil/cli'
require 'anvil/task'
require 'anvil/assure'
require 'anvil/assures/file_assure'
require 'anvil/assures/directory_assure'
