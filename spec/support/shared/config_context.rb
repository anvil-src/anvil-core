shared_context 'init alfred config', config: true do
  before { Alfred::Config.init }
end
