module Anvil
  class Task
    module Files
      def read_file(filename)
        with_file(filename) { |f| f.read.strip }
      end

      def with_file(file, mode = 'r')
        File.open(file, mode) do |f|
          yield(f)
        end
      end
    end
  end
end
