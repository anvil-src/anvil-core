require 'spec_helper'
require 'tasks/gem/bump_task'

describe Gem::BumpTask do
  describe '#task' do
    subject { Gem::BumpTask.new :major }

    it 'bumps the version and writes it' do
      subject.stub(:read_version).and_return('2.0.0')
      subject.should_receive(:write_version)

      subject.task.should eq('3.0.0')
    end
  end
end
