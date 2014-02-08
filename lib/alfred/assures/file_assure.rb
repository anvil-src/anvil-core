module Alfred
  class FileAssure < Alfred::Assure

    def assured?(file)
      assure_exists? file
    end

    def assure_exists?(file)
      File.exists? file
    end
  end
end
