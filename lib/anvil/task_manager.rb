require 'anvil/config'
require 'anvil/task'
require 'rubygems'
require 'bundler/shared_helpers'

module Anvil
  module TaskManager
    @tasks_loaded = false

    def self.load_tasks
      all_files.each { |file| load(file) }
      @tasks_loaded = true
    end

    def self.files_from_anvil
      files_from_path(File.expand_path('../..', __FILE__))
    end

    def self.files_from_current_project
      path = File.dirname(Bundler::SharedHelpers.default_gemfile) + '/lib/anvil/'
      files_from_path(path)
    end

    def self.files_from_path(path)
      Dir[path + '/tasks/**/*_task.rb']
    end

    def self.files_from_gems
      Gem.find_latest_files 'anvil/tasks/**/*_task.rb'
    end

    def self.all_files
      [files_from_anvil,
       files_from_current_project,
       files_from_gems].compact.reduce(&:+).uniq
    end

    def self.all_tasks
      load_tasks unless @tasks_loaded
      ::Anvil::Task.descendants
    end

    def self.tasks_by_name
      all_tasks.sort_by { |t| t.name }
    end
  end
end
