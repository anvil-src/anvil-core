# encoding:utf-8

require 'anvil'
require 'anvil/task'

module Sample
  class HelloNameTask < Anvil::Task
    description 'Say hello to somebody'

    parser do
      arguments %[name]
    end

    attr_reader :name
    def initialize(name, options = {})
      @name = name
    end

    def task
      Anvil.logger.info "Hello #{name}"
    end
  end
end
