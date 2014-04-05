shared_context 'with FakeFS', fakefs: true do
  before { FakeFS.activate! }
  after  { FakeFS.deactivate! }
end
