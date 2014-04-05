# encoding: UTF-8

module Anvil
  # Basic precondition for the tasks. If this fails, the task stops
  class Assure
    class << self
      def from_name(assure_name)
        "#{assure_name}_assure".camelize.constantize
      end
    end
  end
end
