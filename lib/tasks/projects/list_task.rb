require 'anvil/task'

module Projects
  class ListTask < Anvil::Task
    description 'List the projects that anvil can manage.'

    def initialize(_options = {}); end

    def task
      Dir.chdir(Anvil::Config.base_projects_path) { list_projects(projects) }
    end

    def projects
      Dir.glob('*').select { |f| File.directory?(f) }.sort
    end

    def list_projects(names)
      printf("%s\n", names.join("\n"))
    end
  end
end
