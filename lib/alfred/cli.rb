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

      "#{task_name}_task".camelize.constantize.new
    end

    def print_help
      puts <<-HELP
This is the help text
  It should be improved later on
      HELP
    end
  end
end
