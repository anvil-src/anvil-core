require 'spec_helper'

describe Anvil::Config do
  subject { Anvil::Config }
  before  { Anvil::Config.init }

  its('github.user')  { is_expected.to eq('dummy_user') }
  its('github.token') { is_expected.to eq('dummy_token') }

  context '.init_base_path' do
    before  { Anvil::Config.send :init_base_path }
    subject { File }

    it { is_expected.to be_directory(Anvil::Config.base_path) }
    it { is_expected.to be_directory(Anvil::Config.base_tasks_path) }
    it { is_expected.to be_exists(Anvil::Config.base_config_path) }
    it { is_expected.to be_exists(Anvil::Config.base_projects_path) }
  end
end
