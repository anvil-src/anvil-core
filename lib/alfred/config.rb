require 'mixlib/config'

module Alfred
  module Config
    extend Mixlib::Config
    config_strict_mode true

    default :base_config_path, '~/.alfred'
    default(:base_config_file) { "#{base_config_path}/config.rb" }
    default(:base_tasks_path)  { "#{base_config_path}/tasks"}
  end
end
