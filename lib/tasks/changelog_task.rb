require 'anvil/task'
require 'anvil/task/projects'
require 'anvil/task/files'
require 'tasks/changelog_template'

class ChangelogTask < Anvil::Task
  include Anvil::Task::Projects
  include Anvil::Task::Files

  attr_reader :project

  def initialize(project = nil)
    @project = project
  end

  def task
    on_project(project) do |_|
      write_changelog(render_changelog)
    end
  end

  def render_changelog
    ChangelogTemplate.render(read_changelog, read_version_file, git_history)
  end

  def write_changelog(content)
    with_file(changelog_file, 'w') { |f| f.write content }
  end

  def git_history
    %x{git --no-pager log --merges --pretty=format:'%b' \
      `git describe --abbrev=0 --tags`..
      }.split('\n')
  end

  def read_changelog
    with_file(changelog_file) { |f| f.read }
  end

  def changelog_file
    @changelog_file ||= Dir['CHANGELOG*'].first
  end
end
