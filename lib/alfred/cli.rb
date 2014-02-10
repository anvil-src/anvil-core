require 'alfred/task_manager'

module Alfred
  class Cli
    def run(argv)
      load_tasks

      if argv.empty?
        print_help
      elsif argv[0] == 'help'
        help_task(argv[1])
      else
        build_task(argv).run
      end
    end

    def load_tasks
      Alfred::TaskManager.load_tasks
    end

    def help_task(task_name)
      klazz = Task.from_name(task_name)
      puts klazz.help
    end

    def build_task(argv)
      arguments = argv.dup
      task_name = arguments.shift
      klazz     = Task.from_name(task_name)
      klazz.new(*klazz.parse_options!(arguments))
    end

    def print_help
      tasks = Alfred::TaskManager.tasks_by_name
      tasks.each { |task| print_task_line(task) }
    end

    def print_task_line(task)
      printf("%-20s %s\n", task.task_name, task.description)
    end
  end
end
