require 'cocaine'

module Anvil
  class Rubygems
    class << self
      def build(gemspec)
        line = Cocaine::CommandLine.new 'gem', 'build :gemspec'

        line.run gemspec: gemspec
      end

      def install(gem_file)
        line = Cocaine::CommandLine.new 'gem', 'install :gem_file'

        line.run gem_file: gem_file
      end
    end
  end
end
