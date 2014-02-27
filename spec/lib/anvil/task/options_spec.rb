require 'spec_helper'
require 'anvil/task/options'

describe Anvil::Task::Options do
  let(:klass) { DummyTask }

  describe '.define_parser' do
    it 'returns an instance of Anvil::Parser' do
      expect(klass.define_parser).to be_kind_of(Anvil::Parser)
    end
  end

  describe '.parse_options!' do
    let(:klass) do
      Class.new(DummyTask) do
        parser do
          on('-i', '--install') do |i|
            options[:install] = i
          end
        end
      end
    end

    let(:arguments) { %w{arg1 arg2 --install} }

    let(:expected) do
      ['arg1', 'arg2', { install: true }]
    end
    it 'returns the correct arguments and options' do
      expect(klass.parse_options!(arguments)).to be_eql(expected)
    end
  end
end
