require 'spec_helper'

describe Anvil::Config do
  subject { Anvil::Config }
  before  { Anvil::Config.reset }

  its('github.user')  { should be_nil }
  its('github.token') { should be_nil }

  context 'with a config file' do
    include_context 'init anvil config'

    its('github.user')  { should eq('dummy_user') }
    its('github.token') { should eq('dummy_token') }
  end

  context '.init_base_path' do
    before  { Anvil::Config.send :init_base_path }
    subject { File }

    it { should be_directory(Anvil::Config.base_path) }
    it { should be_directory(Anvil::Config.base_tasks_path) }
    it { should be_exists(Anvil::Config.base_config_path) }
    it { should be_exists(Anvil::Config.base_projects_path) }
  end
end
