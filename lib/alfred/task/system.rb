require 'English'

module Alfred
  class Task
    module System
      class ExecuteError < StandardError;
        def initialize(cmd_str, output)
          super("There was an error executing: #{cmd_str}:\n\n#{output}")
        end
      end

      def command(cmd, opts = [])
        opts_str = opts.join(' ')
        cmd_str = "#{cmd} #{opts_str} 2>&1"
        output = run_command(cmd_str)

        fail ExecuteError.new(cmd_str, output) if $CHILD_STATUS.exitstatus > 0

        output
      end

      def run_command(cmd_str)
        `#{cmd_str}`
      end
    end
  end
end
