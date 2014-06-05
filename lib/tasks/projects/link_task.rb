require 'anvil/task'
require 'anvil/config'

module Projects
  class LinkTask < Anvil::Task
    description 'Links a current project to be used by anvil'

    parser do
      arguments %w(name path)
    end

    attr_reader :name, :path

    def initialize(name, path, options = {})
      @name = name
      @path = path
    end

    def task
      Dir.chdir Anvil::Config.base_projects_path do
        FileUtils.ln_sf path, name
      end
    end
  end
end
