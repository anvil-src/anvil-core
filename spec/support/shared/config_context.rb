shared_context 'init anvil config', config: true do
  before { Anvil::Config.init }
end
