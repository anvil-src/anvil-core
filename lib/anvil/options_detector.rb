module Anvil
  # Detect whether the options parser has parsed any option or not in
  # order, for example, to write the required help for them.
  class OptionsDetector
    attr_accessor :has_options

    def on(*_, &_block)
      self.has_options = true
    end

    def arguments(*_, &_block)
    end

    def detect_options(&block)
      instance_eval(&block)

      has_options
    end
  end
end
