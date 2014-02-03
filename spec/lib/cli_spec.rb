require 'spec_helper'

describe Alfred::Cli do
  describe '#run' do
    context 'with a task name' do
      let(:dummy_task) { DummyTask = Class.new(Alfred::Task) }
      let(:argv)       { %w[dummy] }

      before do
        dummy_task.should_receive(:new).and_call_original
        subject.should_not_receive(:print_help)
      end

      it('runs the task in the first parameter') { subject.run argv }
    end

    context 'without a task name' do
      let(:argv) { [] }
      before { subject.should_receive(:print_help) }
      it('prints the help') { subject.run argv }
    end
  end
end
