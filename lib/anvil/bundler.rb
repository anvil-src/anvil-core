require 'cocaine'

module Anvil
  module Bundler
    def install
      line = Cocaine::CommandLine.new 'bundle', 'install'
      require 'byebug';byebug
      line.run
    end

    extend self
  end
end
