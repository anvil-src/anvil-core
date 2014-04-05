# encoding: UTF-8

require 'cocaine'

module Anvil
  # Rubygems wrapper for common commands
  class Rubygems
    class << self
      # Runs gem build for a gemspec
      #
      # @param gemspec [String] The gemspec's filename
      def build(gemspec)
        line = Cocaine::CommandLine.new 'gem', 'build :gemspec'

        line.run gemspec: gemspec
      end

      # Runs gem install for a gem file
      #
      # @param gem_file [String] The gems' filename
      def install(gem_file)
        line = Cocaine::CommandLine.new 'gem', 'install :gem_file'

        line.run gem_file: gem_file
      end

      def push(gem_file)
        line = Cocaine::CommandLine.new 'gem', 'push :gem_file'

        line.run gem_file: gem_file
      end
    end
  end
end
