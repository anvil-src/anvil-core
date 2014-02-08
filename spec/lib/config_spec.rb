require 'spec_helper'

describe Alfred::Config do
  subject { Alfred::Config }

  its(:base_config_path) { should eq('~/.alfred') }
  its(:base_config_file) { should eq('~/.alfred/config.rb') }
  its(:base_tasks_path)  { should eq('~/.alfred/tasks')}
end
