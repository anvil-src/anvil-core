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

      # Yields a block in which PWD is the folder of a project managed
      # by anvil.
      #
      # @param [String] project the name of a project managed by anvil
      # @return [Object] anything returned by the yielded block
      def on_project(project)
        Dir.chdir(project_path(project)) do
          yield(git)
        end
      rescue Errno::ENOENT
        log_project_does_not_exists project
      end

      # Runs on_project on an array of projects
      #
      # @param [Array] projects an array of projects managed by anvil
      # @return [Array] an array with the values returned by each
      #   on_project run
      def on_each_project(projects)
        projects.map do |project|
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
