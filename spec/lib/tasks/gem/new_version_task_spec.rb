require 'spec_helper'
require 'anvil/versioner'
require 'tasks/gem/new_version_task'

describe Gem::NewVersionTask do
  subject { Gem::NewVersionTask.new :major }

  let(:version) { Anvil::Versioner.new('2.0.0') }
  let(:gem_file) { 'new-gem-v2.0.0.gem' }

  describe '#task' do
    before do
      subject.stub(:bump).and_return(version)
      subject.stub(:build).and_return(gem_file)
    end

    it 'pushes the gem to rubygems' do
      subject.should_receive(:push).with(gem_file, version)
    end

    after { subject.task }
  end
end
