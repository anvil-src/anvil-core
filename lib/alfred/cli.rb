module Alfred
  class Cli

    def run(argv)
      if argv.empty?
        print_help
      else
        build_task(argv).run
      end
    end

    protected

    def build_task(argv)
      task_name = argv.first

      Task.from_name(task_name).new
    end

    def print_help
      puts <<-HELP
This is the help text
  It should be improved later on
      HELP
    end
  end
end
