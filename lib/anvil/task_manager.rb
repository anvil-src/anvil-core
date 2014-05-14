# encoding: UTF-8

require 'rubygems'
require 'anvil/config'
require 'anvil/task'
require 'rugged'

module Anvil
  # Manage loading and finding anvil tasks
  module TaskManager
    @tasks_loaded = false

    # Loads all known anvil tasks
    def self.load_tasks
      all_files.each { |file| load(file) }
      @tasks_loaded = true
    end

    # @return [Array] all the core anvil tasks
    def self.files_from_anvil
      files_from_path(File.expand_path('../..', __FILE__))
    end

    # @return [Array] all possible anvil tasks in this project
    def self.files_from_current_project
      path = current_project_path + '/lib/anvil/'
      files_from_path(path)
    end

    # @return [String] top level dir if this is a git managed project
    def self.current_project_path
      Rugged::Repository.discover(ENV['PWD']).gsub('.git/', '')
    rescue Rugged::RepositoryError
      ''
    end

    # @param path [String] a path to glob their anvil tasks
    # @return [Array] all anvil tasks in the given path
    def self.files_from_path(path)
      Dir[path + '/tasks/**/*_task.rb']
    end

    # @return [Array] anvil tasks installed in gems
    def self.files_from_gems
      Gem.find_latest_files 'anvil/tasks/**/*_task.rb'
    end

    # @return [Array] anvil tasks in the specified dir
    def self.files_from_env
      if ENV['ANVIL_TASKS_DIR']
        env_dir_list = ENV['ANVIL_TASKS_DIR'].split(':').join(',')

        Dir["{#{env_dir_list}}/*_task.rb"]
      else
        []
      end
    end

    # @return [Array] all known anvil task files
    def self.all_files
      [files_from_env,
       files_from_anvil,
       files_from_current_project,
       files_from_gems].compact.reduce(&:+).uniq
    end

    # @return [Array] all known {Anvil::Task} desdendants
    def self.all_tasks
      load_tasks unless @tasks_loaded
      ::Anvil::Task.descendants
    end

    def self.tasks_by_name
      all_tasks.sort_by { |t| t.name }
    end
  end
end
