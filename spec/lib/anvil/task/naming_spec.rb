require 'spec_helper'
require 'anvil/task/naming'

describe Anvil::Task::Naming do
  let(:klass) { DummyTask }

  describe '#task_name' do
    it 'returns the correct task name' do
      expect(klass.task_name).to be_eql('dummy')
    end
  end

  describe '.from_name' do
    context 'without a namespace' do
      it 'finds the task class' do
        expect(klass.from_name('dummy')).to eq(DummyTask)
      end
    end

    context 'with a namespace' do
      it 'finds the namespaced tasks class' do
        expect(klass.from_name('foo:dummy')).to eq(Foo::DummyTask)
      end
    end
  end
end
