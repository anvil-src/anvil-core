# encoding: UTF-8

module Anvil
  # Make sure that a directory exists before running the task
  class DirectoryAssure < Anvil::FileAssure
    def assured?(dir)
      super && assure_dir?(dir)
    end

    def assure_dir?(dirname)
      File.directory? dirname
    end
  end
end
