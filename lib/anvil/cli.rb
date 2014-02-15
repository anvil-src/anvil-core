require 'anvil/task_manager'
require 'tasks/help_task'

module Anvil
  class Cli
    HELP = <<-HELP
Anvil is a tool for making your life easier.

Available tasks:
HELP

    def run(argv)
      load_tasks

      if argv.empty?
        print_help
      else
        build_task(argv).run
      end
    end

    def load_tasks
      Anvil::TaskManager.load_tasks
    end

    def build_task(argv)
      arguments = argv.dup
      task_name = arguments.shift
      klazz     = Task.from_name(task_name)
      klazz.new(*klazz.parse_options!(arguments))
    rescue NameError
      task_not_found(task_name)
      exit(FALSE)
    rescue ArgumentError
      help(task_name)
      exit(FALSE)
    end

    def task_not_found(task_name)
      printf("Task '#{task_name}' not found\n\n")
      print_help
    end

    def help(task_name)
      printf("Wrong number of arguments.\n\n")
      HelpTask.run(task_name)
    end

    def print_help
      printf('%s', HELP)
      tasks = Anvil::TaskManager.tasks_by_name
      tasks.each { |task| print_task_line(task) }
    end

    def print_task_line(task)
      printf("%-20s %s\n", task.task_name, task.description)
    end
  end
end
