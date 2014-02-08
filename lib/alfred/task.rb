require 'alfred/task/class_methods'

module Alfred
  class Task
    extend ClassMethods

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def run
      if run_assures
        run_before_callbacks
        run_task
        run_after_callbacks
      end
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
      self.task
    end
  end
end
