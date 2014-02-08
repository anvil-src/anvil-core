require 'spec_helper'

describe Alfred::Config do
  subject { Alfred::Config }
  before  { Alfred::Config.reset }

  its(:base_path)       { should eq('~/.alfred') }
  its(:base_tasks_path) { should eq('~/.alfred/tasks')}

  its("github.user")  { should be_nil }
  its("github.token") { should be_nil }

  context 'with a config file' do
    let(:test_config_path) do
      File.expand_path('./spec/support/dot_alfred', File.dirname(__FILE__))
    end

    before do
      Alfred::Config.stub(:base_path).and_return(test_config_path)
      Alfred::Config.init
    end

    its("github.user")  { should eq('dummy_user') }
    its("github.token") { should eq('dummy_token') }
  end
end
