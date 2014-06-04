# encoding: UTF-8

require 'rubygems'
require 'anvil/task'
require 'rugged'

module Anvil
  # Manage loading and finding anvil tasks
  class ExtensionsManager
    PATTERNS = {
      tasks: '/tasks/**/*_task.rb',
      config_extensions: '/config_extensions/**/*.rb'
    }
    @tasks_loaded = false

    class << self
      attr_accessor :tasks_loaded

      def tasks_by_name
        new.tasks_by_name
      end

      def load_tasks
        new.load_tasks
      end

      def load_config_extensions
        new.load_config_extensions
      end
    end

    def tasks_by_name
      all_tasks.sort_by { |t| t.name }
    end

    # @return [Array] all known {Anvil::Task} desdendants
    def all_tasks
      load_tasks unless self.class.tasks_loaded
      ::Anvil::Task.descendants
    end

    # Loads all known anvil tasks
    def load_tasks
      all_files_for(:tasks).each { |file| load(file) }
      self.class.tasks_loaded = true
    end

    def load_config_extensions
      all_files_for(:config_extensions).each { |file| load(file) }
    end

    # @param extension_type [Symbol] either :tasks or :config.
    # @see {Anvil::ExtensionsManager::PATTERNS}
    # @return [Array] all known anvil files for a given extension type
    def all_files_for(extension_type)
      [files_from_env(extension_type),
       files_from_anvil(extension_type),
       files_from_current_project(extension_type),
       files_from_gems(extension_type)
      ].compact.reduce(&:+).uniq
    end

    # @param extension_type [Symbol] either :tasks or :config.
    # @see {Anvil::ExtensionsManager::PATTERNS}
    # @return [Array] all the core anvil extensions
    def files_from_anvil(extension_type)
      files_from_path(File.expand_path('../..', __FILE__), extension_type)
    end

    # @param extension_type [Symbol] either :tasks or :config.
    # @see {Anvil::ExtensionsManager::PATTERNS}
    # @return [Array] all possible anvil extensions
    def files_from_current_project(pattern)
      path = current_project_path + '/lib/anvil/'
      files_from_path(path, pattern)
    end

    # @param extension_type [Symbol] either :tasks or :config.
    # @see {Anvil::ExtensionsManager::PATTERNS}
    # @return [Array] anvil extensions installed in gems
    def files_from_gems(pattern)
      Gem.find_latest_files "anvil#{PATTERNS[pattern]}"
    end

    # @param extension_type [Symbol] either :tasks or :config.
    # @see {Anvil::ExtensionsManager::PATTERNS}
    # @return [Array] anvil tasks in the specified dir
    def files_from_env(pattern)
      if ENV['ANVIL_EXTENSIONS_DIR']
        env_dir_list = ENV['ANVIL_EXTENSIONS_DIR'].split(':').join(',')

        Dir["{#{env_dir_list}}#{PATTERNS[pattern]}"]
      else
        []
      end
    end

    protected

    # @return [String] top level dir if this is a git managed project
    def current_project_path
      Rugged::Repository.discover(Dir.pwd).gsub('.git/', '')
    rescue Rugged::RepositoryError
      ''
    end

    # @param path [String] a path to glob their anvil tasks
    # @param pattern [Symbol] the pattern to load files
    # @return [Array] all anvil tasks in the given path
    def files_from_path(path, pattern)
      Dir["#{path}#{PATTERNS[pattern]}"]
    end
  end
end
