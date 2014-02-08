require 'spec_helper'

describe Alfred::Config do
  subject { Alfred::Config }
  before  { Alfred::Config.reset }

  its(:base_config_path) { should eq('~/.alfred') }
  its(:base_config_file) { should eq('~/.alfred/config.rb') }
  its(:base_tasks_path)  { should eq('~/.alfred/tasks')}

  context 'with a config file' do
    before do
      Alfred::Config
        .from_file(File.expand_path('../support/others/test_config.rb',
                                    File.dirname(__FILE__)))
    end

    its(:base_config_path) { should eq('../support/dot_alfred') }
    its(:base_tasks_path)  { should eq('../support/dot_alfred/tasks') }
  end
end
