require 'anvil/task'
require 'anvil/versioner'

class Gem::BumpTask < Anvil::Task
  description "Bumps a gem's version"

  parser do
    arguments %w(term)

    on('-p', '--persist', 'Commit tag and push the changes') do |p|
      options[:persist] = true
    end

    on('-f', '--force', 'Act even if the git repo is not clean') do |f|
      options[:force] = true
    end
  end

  attr_reader :term

  def initialize(term, options = {})
    @term = term.to_sym
    @options = options
  end

  def task
    prepare_repo
    version = bump(read_version)
    write_version version.dup.to_s

    version
  end

  protected

  def git
    @git ||= Git.open Dir.pwd
  end

  def version_file(mode = 'r')
    File.open('VERSION', mode) do |f|
      yield f
    end
  end

  def read_version
    version_file { |f| f.read.strip }
  end

  def bump(old_version)
    new_version = Anvil::Versioner.new(old_version).bump! term
    logger.info "Bumped from #{old_version} to #{new_version}"

    new_version
  end

  def commit_and_tag(version)
    git.add 'VERSION'
    git.commit "Bump version v#{version}"
    git.add_tag "v#{version}"
    git.push('origin', git.current_branch)
  end

  def write_version(version)
    version_file('w+') do |f|
      f.puts version
      f.close
    end

    commit_and_tag version if options[:persist]
  end

  def prepare_repo
    if clean? || force?
      git.pull('origin', git.current_branch)
    else
      fail Anvil::RepoNotClean
    end
  end

  def clean?
    git.status.changed.empty? &&
      git.status.deleted.empty? &&
      git.status.added.empty?
  end

  def force?
    options[:force]
  end
end
