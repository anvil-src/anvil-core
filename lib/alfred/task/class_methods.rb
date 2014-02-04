module Alfred
  class Task
    module ClassMethods
      def afters
        @afters ||= []
      end

      def befores
        @befores ||= []
      end

      def assures
        @assures ||= []
      end

      def after(task_name)
        afters << from_name(task_name)
      end

      def assure(assure_name)
        assures << Assure.from_name(assure_name)
      end

      def before(task_name)
        befores << from_name(task_name)
      end

      def from_name(task_name)
        "#{task_name}_task".camelize.constantize
      end
    end
  end
end
