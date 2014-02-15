require 'cocaine'

module Alfred
  class Rubygems
    class << self
      def build(gemspec)
        line = Cocaine::CommandLine.new 'gem', 'build :gemspec'

        line.command gemspec: gemspec
      end

      def install(gem_file)
        line = Cocaine::CommandLine.new 'gem', 'install :gem_file'

        line.command gem_file: gem_file
      end
    end
  end
end
