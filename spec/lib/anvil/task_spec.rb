require 'spec_helper'

describe Anvil::Task do
  let(:dummy_task)  { DummyTask }
  let(:after_task)  { DummyAfterTask }
  let(:before_task) { DummyBeforeTask }
  let(:assure)      { DummyAssure }
  let(:arguments)   { { argument: 'value' } }

  describe '.after' do
    before { dummy_task.class_eval { after :dummy_after, argument: 'value' } }

    subject(:afters) { dummy_task.afters }
    it 'adds DummyBeforeTask to the after callbacks' do
      expect(afters.first).to be_an_instance_of(Anvil::Task::Callback)
      expect(afters.first.task).to be(DummyAfterTask)
    end
  end

  describe '.assure' do
    before { dummy_task.class_eval { assure :dummy } }

    it 'adds DummyAssure to the assures' do
      expect(dummy_task.assures).to include(assure)
    end
  end

  describe '.before' do
    before do
      dummy_task.class_eval { before :dummy_before, argument: 'value' }
    end

    subject(:befores) { dummy_task.befores }
    it 'adds DummyBeforeTask to the before callbacks' do
      expect(befores.first).to be_an_instance_of(Anvil::Task::Callback)
      expect(befores.first.task).to be(DummyBeforeTask)
    end
  end

  describe '#run' do
    before do
      dummy_task.class_eval do
        before :dummy_before
        after :dummy_after
      end
    end
    subject { dummy_task.new }

    context 'with a passing assure' do
      before do
        allow(dummy_task).to receive(:assures).and_return([DummyAssure])
      end

      it 'runs the callbacks and the task' do
        expect(subject).to receive(:run_before_callbacks)
        expect(subject).to receive(:run_after_callbacks)
        expect(subject).to receive(:run_task)
        subject.run
      end
    end

    context 'with a non passing assure' do
      before do
        allow(dummy_task).to receive(:assures).and_return([DummyFailedAssure])
      end

      it 'does not run the callbacks nor the task' do
        expect(subject).to_not receive(:run_before_callbacks)
        expect(subject).to_not receive(:run_after_callbacks)
        expect(subject).to_not receive(:run_task)
        subject.run
      end
    end
  end

  describe '.run' do
    let(:task) { double run: true }
    it 'calls run in a instance of the task' do
      expect(described_class).to receive(:new).and_return(task)
      dummy_task.run(1, 2)
    end
  end
end
