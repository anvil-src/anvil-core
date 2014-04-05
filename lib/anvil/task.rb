# encoding: UTF-8

require 'anvil/task/class_methods'
require 'anvil/task/naming'
require 'anvil/task/options'

module Anvil
  # Common class for all tasks
  class Task
    extend ClassMethods
    extend Naming
    extend Options

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    # Runs a task and its callbacks if the assures are OK
    #
    # @return [Object, nil] anything the task might return
    def run
      if run_assures
        run_before_callbacks
        task_return_value = run_task
        run_after_callbacks

        task_return_value
      end
    end

    def logger
      Anvil.logger
    end

    protected

    def run_after_callbacks
      self.class.afters.each do |after|
        after[0].new(after[1]).run
      end
    end

    def run_assures
      self.class.assures.map { |a| a.new.assured? }.all?
    end

    def run_before_callbacks
      self.class.befores.each do |before|
        before[0].new(before[1]).run
      end
    end

    def run_task
      task
    end
  end
end
