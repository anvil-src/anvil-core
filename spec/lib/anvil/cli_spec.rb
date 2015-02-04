require 'spec_helper'

describe Anvil::Cli do
  # before {FakeFS.deactivate!}
  describe '#run' do
    let(:dummy_task) { DummyTask }
    let(:argv)       { %w[dummy arg1 arg2 --argument value] }

    context 'with a task name' do
      before do
        expect(dummy_task).to receive(:new)
          .with('arg1', 'arg2', argument: 'value').and_call_original
        expect(subject).to_not receive(:print_help)
      end

      it('runs the task in the first parameter') { subject.run argv }
    end

    describe '#build_task' do
      it 'builds the task and parses the arguments' do
        expect(subject.build_task(argv).options).to eq({ argument: 'value' })
      end

      context 'if the task is not found' do
        let(:argv) { %w[ihopethiswillnotexistever arg2] }

        it 'prints task list and exits' do
          expect(subject).to receive(:task_not_found)
            .with('ihopethiswillnotexistever')
          expect do
            subject.build_task(argv)
          end.to raise_error(SystemExit)
        end
      end

      context 'if the arguments are not the correct' do
        let(:argv) { %w[foo:dummy arg1 arg2 arg3 arg4 arg5 arg6 arg7] }

        it 'prints task list and exits' do
          expect(subject).to receive(:bad_arguments).with('foo:dummy')
          expect do
            subject.build_task(argv)
          end.to raise_error(SystemExit)
        end
      end
    end

    context 'without a task name' do
      let(:argv)            { [] }
      before                { expect(subject).to receive(:print_help_body) }
      it('prints the help') { subject.run argv }
    end
  end
end
