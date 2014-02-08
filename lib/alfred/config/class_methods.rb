require 'fileutils'

module Alfred
  module Config
    module ClassMethods
      def base_path
        File.expand_path "~/.alfred"
      end

      def base_tasks_path
        "#{base_path}/tasks"
      end

      def base_config_path
        "#{base_path}/config.rb"
      end

      def init
        init_base_path
        init_config
      end

      protected

      def init_base_path
        unless File.directory? base_path
          FileUtils.mkdir_p base_path
          FileUtils.mkdir_p base_tasks_path
          FileUtils.touch base_config_path
        end
      end

      def init_config
        from_file base_config_path
      end
    end
  end
end
