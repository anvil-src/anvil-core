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
      afters.first.should be_an_instance_of Anvil::Task::Callback
      afters.first.task.should be DummyAfterTask
    end
  end

  describe '.assure' do
    before { dummy_task.class_eval { assure :dummy } }

    it 'adds DummyAssure to the assures' do
      dummy_task.assures.should include(assure)
    end
  end

  describe '.before' do
    before do
      dummy_task.class_eval { before :dummy_before, argument: 'value' }
    end

    subject(:befores) { dummy_task.befores }
    it 'adds DummyBeforeTask to the before callbacks' do
      befores.first.should be_an_instance_of Anvil::Task::Callback
      befores.first.task.should be DummyBeforeTask
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
      before { dummy_task.stub(:assures).and_return([DummyAssure]) }

      it 'runs the callbacks and the task' do
        subject.should_receive(:run_before_callbacks)
        subject.should_receive(:run_after_callbacks)
        subject.should_receive(:run_task)
        subject.run
      end
    end

    context 'with a non passing assure' do
      before { dummy_task.stub(:assures).and_return([DummyFailedAssure]) }

      it 'does not run the callbacks nor the task' do
        subject.should_not_receive(:run_before_callbacks)
        subject.should_not_receive(:run_after_callbacks)
        subject.should_not_receive(:run_task)
        subject.run
      end
    end
  end

  describe '.run' do
    it 'calls run in a instance of the task' do
      dummy_task.any_instance.should_receive(:run)
      dummy_task.run(1, 2)
    end
  end
end
