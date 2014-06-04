require 'git'

module Anvil
  class Task
    module Projects
      def project_path(project)
        Anvil::Config.base_projects_path + "/#{project}"
      end

      def change_project(project)
        Dir.chdir(project_path(project))
      rescue Errno::ENOENT
        log_project_does_not_exists project
      end

      def on_project(project)
        Dir.chdir(project_path(project)) do
          yield(git)
        end
      rescue Errno::ENOENT
        log_project_does_not_exists project
      end

      def on_each_project(projects)
        projects.each do |project|
          on_project(project) { |project_git| yield project, project_git }
        end
      end

      protected

      def log_project_does_not_exists(project)
        logger.info "Anvil knows nothing about #{project}."
        logger.info 'Please, check anvil help projects:add first to add the project to anvil.'
      end

      def git
        Git.open(Dir.pwd)
      end
    end
  end
end
