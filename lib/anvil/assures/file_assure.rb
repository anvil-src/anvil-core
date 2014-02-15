module Anvil
  class FileAssure < Anvil::Assure
    def assured?(file)
      assure_exists? file
    end

    def assure_exists?(file)
      File.exists? file
    end
  end
end
