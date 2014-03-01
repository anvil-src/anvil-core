require 'anvil/version'
require 'active_support/core_ext'

module Anvil
  Error = Class.new(StandardError)

  class << self
    def logger
      @logger ||= Logger.new(STDOUT).tap do |l|
        l.formatter = proc do |*_, msg|
          msg
        end
      end
    end
  end
end

require 'anvil/config'
require 'anvil/cli'
require 'anvil/task'
require 'anvil/assure'
require 'anvil/assures/file_assure'
require 'anvil/assures/directory_assure'
