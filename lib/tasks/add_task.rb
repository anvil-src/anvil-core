require 'alfred/task'
require 'alfred/task/repositories'
require 'alfred/config'
require 'git'
require_relative 'gem_build_task'

class AddTask < Alfred::Task
  include Alfred::Task::Repositories
  description 'Adds new alfred tasks sets from a git repository.'

  parser do
    arguments %w[repository]
  end

  def initialize(repo, options = {})
    @repo = repo
  end

  def task
    url_to_clone = resolve_url(@repo)
    name = url_to_clone.match(/.*\/(.*)$/)[1]

    clone_repo(url_to_clone, name)
    install(name)
  end

  def clone_repo(url, name)
    Dir.chdir(Alfred::Config.base_tasks_path) { Git.clone(url, name) }
  end

  def install(name)
    gemspec_file = gemspec(name)

    GemBuildTask.run(gemspec_file) if gemspec_file
  end

  def gemspec(name)
    path = "#{Alfred::Config.base_tasks_path}/#{name}"
    Dir[path + '/*.gemspec'].first
  end
end
