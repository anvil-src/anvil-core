module Anvil
  class Assure
    class << self
      def from_name(assure_name)
        "#{assure_name}_assure".camelize.constantize
      end
    end
  end
end
