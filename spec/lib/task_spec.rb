require 'spec_helper'

describe Alfred::Task do
  let(:dummy_task) { DummyTask }

  describe '.after' do
    let!(:after_task) { DummyAfterTask }
    before { dummy_task.class_eval { after :dummy_after } }

    it 'adds DummyBeforeTask to the after callbacks' do
      dummy_task.afters.should include(after_task)
    end
  end

  describe '.assure' do
    let!(:assure) { DummyAssure }
    before { dummy_task.class_eval { assure :dummy } }

    it 'adds DummyAssure to the assures' do
      dummy_task.assures.should include(assure)
    end
  end

  describe '.before' do
    let!(:before_task) { DummyBeforeTask }
    before { dummy_task.class_eval { before :dummy_before } }

    it 'adds DummyBeforeTask to the before callbacks' do
      dummy_task.befores.should include(before_task)
    end
  end

  describe '#run' do
  end
end
