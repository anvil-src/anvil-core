require 'anvil/task'
require 'anvil/task/projects'
require 'anvil/config'
require 'anvil/versioner'
require 'anvil/bundler'
require 'erb'

module Projects
  class BumpTask < Anvil::Task
    include Anvil::Task::Projects

    attr_reader :project, :options

    description 'Bump a new version of a project'
    parser do
      on('-s', '--source BRANCH') do |value|
        options[:source] = value
      end

      on('t', '--term TERM') do |value|
        options[:term] = value
      end
    end

    class ChangelogTemplate
      def self.render(*args)
        new(*args).render
      end

      attr_reader :version, :history

      def initialize(version, history)
        @version = version
        @history = history
      end

      def template_path
        File.expand_path(File.dirname(__FILE__) + '/templates/changelog.erb')
      end

      def actual_date
        Time.new.strftime('%d %B %Y %H:%M')
      end

      def public_binding
        binding
      end

      def render
        template = ERB.new(File.read(template_path), 0, '%<>')
        template.result(public_binding)
      end
    end

    def initialize(project, options = {})
      @project = project
      @options = options
    end

    def task
      source = source_branch(project)
      target = target_branch(project, source)

      on_project(project) do |git|
        update_branch(git, source)
        merge(git, source, target)
        change_version(git)
        changelog(git)
        update_gemfile_lock(git)
        # git commit
      end
    end

    def merge(git, source, target)
      return if source == target

      update_branch(git, target)
      git.merge(source, nil)
    end

    def update_branch(git, branch)
      git.checkout(branch)
      git.pull('origin', branch)
    end

    def change_version(git)
      File.open('VERSION', 'a+') do |file|
        versioner = Anvil::Versioner.new(file.read)
        file.truncate(0)
        term = options[:term] || 'minor'
        new_version = versioner.send("#{term}!")

        file.write(new_version.to_s)
      end

      git.add('VERSION')
    end

    def changelog(git)
      filename = changelog_file
      actual_changelog = File.read(filename)
      version = File.read('VERSION')
      history = git_changelog

      File.open(filename, 'w+') do |file|
        file << ChangelogTemplate.render(version, history)
        file << actual_changelog
      end

      git.add(filename)
    end

    def update_gemfile_lock(git)
      return unless gem?

      Anvil::Bundler.install
      git.add(gemspec_file)
    end

    def gem?
      !!gemspec_file
    end

    def changelog_file
      Dir['CHANGELOG*'].first
    end

    def gemspec_file
      Dir['*.gemspec'].first
    end

    def git_changelog
      %x{git --no-pager log --merges --pretty=format:'%b' `git describe --abbrev=0 --tags`..}.split("\n")
    end

    def target_branch(project, source)
      flow = flow_for_project(project)
      flow[flow.index(source) + 1]
    end

    def source_branch(project)
      @options[:source] || flow_for_project(project).first
    end

    def flow_for_project(project)
      project_config(project).flow || ['master']
    end

    def project_config(project)
      projects_config && projects_config.send(project.to_sym) ||
        projects_config
    end

    def projects_config
      Anvil::Config.projects
    end
  end
end
