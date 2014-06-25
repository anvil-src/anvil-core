require 'spec_helper'
require 'anvil/task/naming'

describe Anvil::Task::Callback do

  subject(:callback) { Anvil::Task::Callback.new(:dummy, option: 'value') }

  describe '#new' do
    it 'sets the task by the name' do
      expect(callback.task).to be DummyTask
    end

    it 'sets the options' do
      expect(callback.options).to include(option: 'value')
    end
  end

  describe '.run' do
    let(:dummy_task) { DummyTask.new }

    it 'runs the task' do
      expect(DummyTask).to receive(:new)
        .with(option: 'value')
        .and_return(dummy_task)
      expect(dummy_task).to receive(:run)
      callback.run
    end
  end
end
