require 'spec_helper'
require 'tasks/gem/bump_task'

describe Gem::BumpTask do
  describe '#task' do
    subject { Gem::BumpTask.new :major }
    before  { subject.stub(:read_version).and_return('2.0.0') }

    it 'bumps the version and writes it' do
      expect(subject).to receive(:write_version)

      expect(subject.task).to eq('3.0.0')
    end
  end
end
