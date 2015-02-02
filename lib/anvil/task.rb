# encoding: UTF-8

require 'anvil/task/class_methods'
require 'anvil/task/naming'
require 'anvil/task/options'
require 'anvil/task/callback'

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
      return unless run_assures
      run_before_callbacks
      task_return_value = run_task
      run_after_callbacks

      task_return_value
    end

    def logger
      Anvil.logger
    end

    protected

    def run_after_callbacks
      self.class.afters.each { |callback| callback.run }
    end

    def run_assures
      self.class.assures.map { |a| a.new.assured? }.all?
    end

    def run_before_callbacks
      self.class.befores.each { |callback| callback.run }
    end

    def run_task
      task
    end
  end
end
