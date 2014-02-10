require 'spec_helper'

describe Alfred::Cli do
  # before {FakeFS.deactivate!}
  describe '#run' do
    let(:dummy_task) { DummyTask }
    let(:argv)       { %w[dummy arg1 arg2 --argument value] }

    context 'with a task name' do
      before do
        dummy_task.should_receive(:new)
          .with('arg1', 'arg2', argument: 'value').and_call_original
        subject.should_not_receive(:print_help)
      end

      it('runs the task in the first parameter') { subject.run argv }
    end

    describe '#build_task' do
      it 'builds the task and parses the arguments' do
        subject.build_task(argv).options.should == { argument: 'value' }
      end

      context 'if the task is not found' do
        let(:argv) { %w[ihopethiswillnotexistever arg2] }

        it 'prints task list and exits' do
          expect do
            expect(subject).to receive(:task_not_found)
              .with('ihopethiswillnotexistever')
            subject.build_task(argv)
          end.to raise_error(SystemExit)
        end
      end

      context 'if the arguments are not the correct' do
        let(:argv) { %w[foo:dummy arg1 arg2 arg3 arg4 arg5 arg6 arg7] }

        it 'prints task list and exits' do
          expect do
            expect(subject).to receive(:help).with('foo:dummy')
            subject.build_task(argv)
          end.to raise_error(SystemExit)
        end
      end
    end

    context 'without a task name' do
      let(:argv)            { [] }
      before                { subject.should_receive(:print_help) }
      it('prints the help') { subject.run argv }
    end
  end
end
