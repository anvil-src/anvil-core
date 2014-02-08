require 'spec_helper'

describe Alfred::Cli do
  # before {FakeFS.deactivate!}
  describe '#run' do
    let(:dummy_task) { DummyTask }
    let(:argv)       { %w[dummy --argument value] }

    context 'with a task name' do
      before do
        dummy_task.should_receive(:new)
          .with({argument: 'value'}).and_call_original
        subject.should_not_receive(:print_help)
      end

      it('runs the task in the first parameter') { subject.run argv }
    end

    describe '#build_task' do
      it 'builds the task and parses the arguments' do
        subject.build_task(argv).options.should == {argument: 'value'}
      end
    end

    context 'without a task name' do
      let(:argv)            { [] }
      before                { subject.should_receive(:print_help) }
      it('prints the help') { subject.run argv }
    end
  end
end
