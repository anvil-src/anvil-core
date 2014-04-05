require 'active_support/core_ext/string'

module Anvil
  class Task
    # Methods for inferring task class names from cli arguments
    module Naming
      def get_namespace(task_name)
        task_name.to_s.split ':'
      end

      # Returns a ruby class from a CLI name
      #
      # @param task_name [String] the CLI name for a task e.g. anvil:build
      # @return [Class] an {Anvil::Task} descendant
      def from_name(task_name)
        namespaced_task     = get_namespace task_name
        camelized_task      = "#{namespaced_task.pop}_task".camelize
        camelized_namespace = "#{namespaced_task.shift}".camelize

        "#{camelized_namespace}::#{camelized_task}".constantize
      end

      def task_name
        name[/(.*)Task/, 1].underscore.gsub('/', ':')
      end

      def description(str = nil)
        return @description unless str
        @description = str
      end
    end
  end
end
