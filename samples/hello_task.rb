# encoding:utf-8

require 'anvil'
require 'anvil/task'

# Prints Hello world to the STDOUT
module Sample
  class HelloTask < Anvil::Task
    description 'Prints Hello world'

    def task
      Anvil.logger.info 'Hello world'
    end
  end
end
