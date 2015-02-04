# encoding: UTF-8

require 'anvil/extensions_manager'
require 'tasks/help_task'

module Anvil
  # Anvil command line interface
  class Cli
    HELP_HEADER = <<-HELP_HEADER
Anvil is a tool for making your life easier.

Available tasks:
HELP_HEADER

    # Runs a task or prints its help if it needs arguments
    #
    # @param argv [Array] Command line arguments
    # @return [Object, nil] Anything the task returns
    def run(argv)
      load_tasks

      return build_task(argv).run unless argv.empty?

      print_help_header
      print_help_body
    end

    def load_tasks
      Anvil::ExtensionsManager.load_tasks
    end

    # Builds a task and prepares it to run
    #
    # @param argv [Array] Command line arguments
    # @return [Anvil::Task] A task ready to run
    def build_task(argv)
      arguments = argv.dup
      task_name = arguments.shift
      klazz     = Task.from_name(task_name)
      klazz.new(*klazz.parse_options!(arguments))
    rescue NameError
      task_not_found(task_name)
      exit false
    rescue ArgumentError
      bad_arguments(task_name)
      exit false
    end

    def task_not_found(task_name = nil)
      Anvil.logger.info "Task '#{task_name}' not found"
      Anvil.logger.info('Maybe you mean one of the following') if task_name
      Anvil.logger.info("\n")
      print_help_body task_name
    end

    def bad_arguments(task_name)
      Anvil.logger.info("Wrong number of arguments.\n")
      HelpTask.run(task_name)
    end

    def print_help_body(task_name = nil)
      task_list(task_name).each { |task| print_task_line(task) }
    end

    def task_list(task_name)
      tasks = Anvil::ExtensionsManager.tasks_by_name

      return tasks unless task_name
      tasks.select { |task| task.to_s.underscore =~ /#{task_name}/ }
    end

    def print_task_line(task)
      message = format '%-20s %s', task.task_name, task.description
      Anvil.logger.info message
    end

    def print_help_header
      Anvil.logger.info HELP_HEADER
    end
  end
end
