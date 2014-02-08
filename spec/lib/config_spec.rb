require 'spec_helper'

describe Alfred::Config do
  subject { Alfred::Config }
  before  { Alfred::Config.reset }

  its("github.user")  { should be_nil }
  its("github.token") { should be_nil }

  context 'with a config file' do
    let(:test_config_path) do
      File.expand_path('./spec/support/dot_alfred', File.dirname(__FILE__))
    end

    before do
      Alfred::Config.stub(:base_path).and_return(test_config_path)
      Alfred::Config.send :init_config
    end

    its("github.user")  { should eq('dummy_user') }
    its("github.token") { should eq('dummy_token') }
  end

  context '.init_base_path' do
    before { Alfred::Config.send :init_base_path }
    subject { File }

    it { should be_directory(Alfred::Config.base_path) }
    it { should be_directory(Alfred::Config.base_tasks_path) }
    it { should be_exists(Alfred::Config.base_config_path) }
  end
end
