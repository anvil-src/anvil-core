module Alfred
  class DirectoryAssure < Alfred::FileAssure

    def assured?(dir)
      super && assure_dir?(dir)
    end

    def assure_dir?(dirname)
      File.directory? dirname
    end
  end
end
