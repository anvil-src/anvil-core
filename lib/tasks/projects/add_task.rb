require 'alfred/task'
require 'alfred/task/repositories'
require 'alfred/config'
require 'git'

module Projects
  class AddTask < Alfred::Task
    include Alfred::Task::Repositories
    description 'Adds a new project for alfred.'

    parser do
      arguments %w[name repository]
    end

    attr_reader :name, :repo

    def initialize(name, repo, options = {})
      @name = name
      @repo = repo
    end

    def task
      url_to_clone = resolve_url(repo)
      clone_repo(url_to_clone, name)
    end

    def clone_repo(url, name)
      Dir.chdir(Alfred::Config.base_projects_path) { Git.clone(url, name) }
    end
  end
end
