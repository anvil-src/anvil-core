require 'optparse'

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
        namespaced_task     = get_namespace task_name
        camelized_task      = "#{namespaced_task.pop}_task".camelize
        camelized_namespace = "#{namespaced_task.shift}".camelize

        "#{camelized_namespace}::#{camelized_task}".constantize
      end

      def parse_options(arguments)
        {}
      end

      protected

      def get_namespace(task_name)
        task_name.to_s.split ':'
      end
    end
  end
end
