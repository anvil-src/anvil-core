# encoding: UTF-8

require 'spec_helper'

describe Anvil::Parser do
  let(:task) { DummyTask }

  describe '#from' do
    before do
      task.stub(:parser_block).and_return(proc { 'opts' })
    end

    it 'inherits parser block from another task' do
      expect(subject.from('dummy')).to eq('opts')
    end
  end
end
