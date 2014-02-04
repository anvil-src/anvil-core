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
        afters << task_from_name(task_name)
      end

      def assure(assure_name)
        assures << assure_from_name(assure_name)
      end

      def before(task_name)
        befores << task_from_name(task_name)
      end

      protected

      def task_from_name(task_name)
        "#{task_name}_task".camelize.constantize
      end

      def assure_from_name(assure_name)
        "#{assure_name}_assure".camelize.constantize
      end
    end
  end
end
