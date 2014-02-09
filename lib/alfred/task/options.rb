require 'alfred/parser'

module Alfred
  class Task
    module Options
      def help
        parser.help
      end

      def parser(&block)
        @parser ||= define_parser(&block)
      end

      def define_parser(&block)
        parser = Alfred::Parser.new
        parser.task = self
        configure_parser(parser, &block)
        parser
      end

      def configure_parser(parser, &block)
        block ||= proc {}

        if description
          parser.separator ''
          parser.separator description
        end

        parser.separator ''
        parser.separator 'These are the available options:'
        parser.instance_eval(&block)
        parser
      end

      def parse_options!(arguments)
        parser.parse!(arguments)
        arguments << parser.options
      end
    end
  end
end
