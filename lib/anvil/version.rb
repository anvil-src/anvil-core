module Anvil
  class << self
    def version
      version_path =
        File.expand_path("#{File.dirname __FILE__}../../../VERSION")

      File.read(version_path)
    end
  end

  VERSION = Anvil.version
end
