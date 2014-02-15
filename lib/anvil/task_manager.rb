require 'anvil/config'

module Anvil
  module TaskManager
    def self.task_dirs
      Dir[Anvil::Config.base_tasks_path + '/*'] << anvil_tasks_dir
    end

    def self.anvil_tasks_dir
      File.expand_path('../../..', __FILE__)
    end

    def self.load_tasks
      task_dirs.each do |dir|
        Dir[dir + '/lib/tasks/**/*_task.rb'].each { |task_file| load(task_file) }
      end
    end

    def self.tasks_by_name
      all_tasks.sort_by { |t| t.name }
    end

    def self.all_tasks
      ::Anvil::Task.descendants
    end
  end
end
