module Anvil
  class Bundler
    def self.update_gem(gem_name)
      ::Bundler.with_clean_env do
        Cocaine::CommandLine.runner = Cocaine::CommandLine::PopenRunner.new
        line = Cocaine::CommandLine.new('bundle', "update #{gem_name}")
        line.run
      end
    end
  end
end
