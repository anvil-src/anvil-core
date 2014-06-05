require 'anvil/task'

module Projects
  class ListTask < Anvil::Task
    description 'List the projects that anvil can manage.'

    def initialize(options = {}); end

    def task
      Dir.chdir(Anvil::Config.base_projects_path) do
        logger.info "\n"
        logger.info 'Cloned projects'
        logger.info '***************'

        list_cloned_projects
        logger.info "\n"

        logger.info 'Linked projects'
        logger.info '***************'

        list_linked_projects
        logger.info "\n"
      end
    end

    def list_cloned_projects
      names = Dir.glob('*').select do |f|
        File.directory?(f) && !File.symlink?(f)
      end.sort

      logger.info names.join("\n")
    end

    def list_linked_projects
      names = Dir.glob('*').select { |f| File.symlink? f }.sort

      names.each do |name|
        target = File.readlink(name)
        stat = File.stat(name) rescue nil
        if stat
          logger.info "#{name}: links to #{target}"
        else
          logger.info "#{name}: dead link to #{target}"
        end
      end
    end

    def list_projects(names)
      logger.info names.join("\n")
      logger.info "\n"
    end
  end
end
