require 'anvil/task'

module Anvil
  class Parser < OptionParser
    attr_accessor :options
    attr_accessor :task

    def options
      @options ||= {}
    end

    def arguments(args = nil)
      return @arguments if @arguments
      @arguments = args if args
    end

    def banner
      unless @banner
        @banner = banner_string
        visit(:add_banner, @banner)
      end

      @banner
    end

    def banner_string
      args = arguments.map(&:upcase).join(' ')
      message = "Usage: anvil #{task.task_name}"
      message += " #{args}" unless args.empty?
      message += ' [options]'

      message
    end

    def from(name)
      task_klass = Anvil::Task.from_name(name)
      instance_eval(&task_klass.parser_block) if task_klass.parser_block
    end
  end
end
