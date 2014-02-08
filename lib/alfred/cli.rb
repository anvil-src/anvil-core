require 'alfred/task_manager'

module Alfred
  class Cli

    def run(argv)
      if argv.empty?
        print_help
      else
        load_tasks
        build_task(argv).run
      end
    end

    def load_tasks
      Alfred::TaskManager.load_tasks
    end

    def build_task(argv)
      arguments = argv.dup
      task_name = arguments.shift
      klazz     = Task.from_name(task_name)
      klazz.new(*klazz.parse_options(arguments))
    end

    def print_help
      puts <<-HELP
This is the help text
  It should be improved later on
      HELP
    end
  end
end
