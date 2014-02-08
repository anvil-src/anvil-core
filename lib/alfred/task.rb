require 'alfred/task/class_methods'

module Alfred
  class Task
    extend ClassMethods

    def run
      if run_assures
        run_before_callbacks
        run_task
        run_after_callbacks
      end
    end

    protected

    def run_after_callbacks
      self.class.afters.map(&:new).map(&:run)
    end

    def run_assures
      self.class.assures.map { |a| a.new.assured? }.all?
    end

    def run_before_callbacks
      self.class.befores.map(&:new).map(&:run)
    end

    def run_task
      self.task
    end
  end
end
