require 'spec_helper'
require 'alfred/task/system'

describe Alfred::Task::System do
  let(:klass) do
    Class.new(DummyTask) do
      include Alfred::Task::System
    end
  end

  subject { klass.new }

  describe '#command' do
    let(:cmd) { 'gem' }
    let(:opts) { ['install alfred.gem', '--no-ri' ] }

    it 'calls #run_command with the correct command string' do
      subject.should_receive(:run_command)
        .with('gem install alfred.gem --no-ri 2>&1')

      subject.command(cmd, opts)
    end
  end
end
