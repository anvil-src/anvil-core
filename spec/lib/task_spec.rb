require 'spec_helper'

describe Alfred::Task do
  let(:dummy_task)  { DummyTask }
  let(:after_task)  { DummyAfterTask }
  let(:before_task) { DummyBeforeTask }
  let(:assure)      { DummyAssure }
  let(:arguments)   { { argument: 'value' } }

  describe '.after' do
    before { dummy_task.class_eval { after :dummy_after, argument: 'value' } }

    it 'adds DummyBeforeTask to the after callbacks' do
      dummy_task.afters.should include([after_task, arguments])
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

    it 'adds DummyBeforeTask to the before callbacks' do
      dummy_task.befores.should include([before_task, arguments])
    end
  end

  describe '.from_name' do
    context 'without a namespace' do
      it 'finds the task class' do
        described_class.from_name('dummy').should eq(DummyTask)
      end
    end

    context 'with a namespace' do
      it 'finds the namespaced tasks class' do
        described_class.from_name('foo:dummy').should eq(Foo::DummyTask)
      end
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

      it 'does not run the callbacks or the task' do
        subject.should_not_receive(:run_before_callbacks)
        subject.should_not_receive(:run_after_callbacks)
        subject.should_not_receive(:run_task)
        subject.run
      end
    end
  end
end
