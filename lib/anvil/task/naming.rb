require 'active_support/core_ext/string'

module Anvil
  class Task
    module Naming
      def get_namespace(task_name)
        task_name.to_s.split ':'
      end

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
