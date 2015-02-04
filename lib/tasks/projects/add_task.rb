require 'anvil/task'
require 'anvil/task/repositories'
require 'anvil/config'
require 'git'

module Projects
  class AddTask < Anvil::Task
    include Anvil::Task::Repositories
    description 'Adds a new project for anvil.'
    parser { arguments %w(name repository) }

    attr_reader :name, :repo

    def initialize(name, repo, _options = {})
      @name = name
      @repo = repo
    end

    def task
      url_to_clone = resolve_url(repo)
      logger.info "Clonning #{repo} on anvil's projects folder."
      clone_repo(url_to_clone, name)
    end

    def clone_repo(url, name)
      Dir.chdir(Anvil::Config.base_projects_path) { Git.clone(url, name) }
    end
  end
end
