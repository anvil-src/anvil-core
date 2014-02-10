module Projects
  class ListTask < Alfred::Task
    description 'List the projects that alfred can manage.'

    def initialize(options = {}); end

    def task
      Dir.chdir(Alfred::Config.base_projects_path) { list_projects(projects) }
    end

    def projects
      Dir.glob('*').select { |f| File.directory?(f) }.sort
    end

    def list_projects(names)
      printf("%s\n", names.join("\n"))
    end
  end
end
