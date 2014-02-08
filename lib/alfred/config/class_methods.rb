module Alfred
  module Config
    module ClassMethods
      def base_path
        "~/.alfred"
      end

      def base_tasks_path
        "#{base_path}/tasks"
      end

      def base_config_path
        "#{base_path}/config.rb"
      end

      def init
        self.from_file base_config_path
      end
    end
  end
end
