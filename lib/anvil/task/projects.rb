require 'git'

module Anvil
  class Task
    module Projects
      def project_path(project)
        Anvil::Config.base_projects_path + "/#{project}"
      end

      def change_project(project)
        Dir.chdir(project_path(project))
      end

      def on_project(project)
        Dir.chdir(project_path(project)) do
          yield(git)
        end
      end

      def on_each_project(projects)
        projects.each do |project|
          on_project(project) { |project_git| yield project_git }
        end
      end

      protected

      def git
        Git.open(Dir.pwd)
      end
    end
  end
end
