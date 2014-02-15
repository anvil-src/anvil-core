require 'anvil/task'
require 'anvil/task/repositories'
require 'anvil/config'
require 'git'
require_relative 'gem_build_task'

class AddTask < Anvil::Task
  include Anvil::Task::Repositories
  description 'Adds new anvil tasks suite from a git repository.'

  parser do
    arguments %w[repository]
  end

  attr_reader :repo

  def initialize(repo, options = {})
    @repo = repo
  end

  def task
    url_to_clone = resolve_url(repo)
    name = url_to_clone.match(/.*\/(.*)$/)[1]

    clone_repo(url_to_clone, name)
    install(name)
  end

  def clone_repo(url, name)
    Dir.chdir(Anvil::Config.base_tasks_path) { Git.clone(url, name) }
  end

  def install(name)
    gemspec_file = gemspec(name)

    GemBuildTask.run(gemspec_file) if gemspec_file
  end

  def gemspec(name)
    path = "#{Anvil::Config.base_tasks_path}/#{name}"
    Dir[path + '/*.gemspec'].first
  end
end
