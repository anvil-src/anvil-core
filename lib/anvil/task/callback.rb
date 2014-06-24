require 'anvil/task/naming'

module Anvil
  class Task
    class Callback
      include Anvil::Task::Naming

      attr_reader :task, :options

      def initialize(task_name, options)
        @task, @options = from_name(task_name), options
      end

      def run
        task.new(options).run
      end
    end
  end
end
