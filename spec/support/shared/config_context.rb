shared_context 'init anvil config', config: true do
  include_context 'with FakeFS'

  let(:test_config_path) do
    File.expand_path('./spec/support/dot_anvil', File.dirname(__FILE__))
  end

  before do
    Anvil::Config.stub(:base_path).and_return(test_config_path)
    Anvil::Config.init
  end
end
