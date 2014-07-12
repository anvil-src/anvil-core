require 'spec_helper'
require 'anvil/versioner'
require 'tasks/gem/release_task'

describe Gem::ReleaseTask do
  subject { Gem::ReleaseTask.new :major }

  let(:version) { Anvil::Versioner.new('2.0.0') }
  let(:gem_file) { 'new-gem-v2.0.0.gem' }

  describe '#task' do
    before do
      allow(subject).to receive(:bump).and_return(version)
      allow(subject).to receive(:build).and_return(gem_file)
    end

    it 'pushes the gem to rubygems' do
      expect(subject).to receive(:push).with(gem_file, version)
    end

    after { subject.task }
  end
end
