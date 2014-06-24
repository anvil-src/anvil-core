# encoding: UTF-8

require 'optparse'

module Anvil
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

      def after(task_name, options = {})
        afters << Callback.new(task_name, options)
      end

      def assure(assure_name)
        assures << Assure.from_name(assure_name)
      end

      def before(task_name, options = {})
        befores << Callback.new(task_name, options)
      end

      def run(*args)
        new(*args).run
      end

      def descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end
    end
  end
end
