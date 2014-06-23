require 'anvil/task/naming'

module Anvil
  class Callback
    extend Naming

    attr_reader :task, :options

    def initialize(task_name, options)
      @task, @options = from_name(task), options
    end

    def run
      task.new(options).run
    end
  end
end
