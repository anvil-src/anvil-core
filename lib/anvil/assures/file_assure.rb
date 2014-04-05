# encoding: UTF-8

module Anvil
  # Make sure that a file exists before running the task
  class FileAssure < Anvil::Assure
    def assured?(file)
      assure_exists? file
    end

    def assure_exists?(file)
      File.exists? file
    end
  end
end
