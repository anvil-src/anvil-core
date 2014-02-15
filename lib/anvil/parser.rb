module Anvil
  class Parser < OptionParser
    attr_accessor :options
    attr_accessor :task

    def options
      @options ||= {}
    end

    def arguments(args = [])
      @arguments ||= []
      @arguments += args if args.any?
      @arguments.compact
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
      message = "Usage: alfred #{task.task_name}"
      message += " #{args}" unless args.empty?
      message += ' [options]'

      message
    end
  end
end
