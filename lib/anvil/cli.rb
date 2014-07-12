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

      if argv.empty?
        print_help_header
        print_help_body
      else
        build_task(argv).run
      end
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
      printf("Task '#{task_name}' not found\n")
      printf("Maybe you mean one of the following\n") if task_name
      printf("\n")
      print_help_body task_name
    end

    def bad_arguments(task_name)
      printf("Wrong number of arguments.\n\n")
      HelpTask.run(task_name)
    end

    def print_help_body(task_name = nil)
      task_list(task_name).each { |task| print_task_line(task) }
    end

    def task_list(task_name)
      tasks = Anvil::ExtensionsManager.tasks_by_name
      list = if task_name
               tasks.select { |task| task.to_s.underscore =~ /#{task_name}/ }
             else
               tasks
             end

      list.empty? ? tasks : list
    end

    def print_task_line(task)
      printf("%-20s %s\n", task.task_name, task.description)
    end

    def print_help_header
      printf('%s', HELP_HEADER)
    end
  end
end
