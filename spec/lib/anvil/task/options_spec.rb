# encoding: UTF-8

require 'spec_helper'
require 'anvil/task/options'

describe Anvil::Task::Options do
  let(:klass) do
    Class.new do
      def self.description
        'Dummy task'
      end

      extend Anvil::Task::Options

      parser do
        on('-i', '--install') do |i|
          options[:install] = i
        end
      end
    end
  end

  describe '.build_parser' do
    it 'returns an instance of Anvil::Parser' do
      expect(klass.build_parser).to be_kind_of(Anvil::Parser)
    end
  end

  describe '.parse_options!' do
    let(:arguments) { %w{arg1 arg2 --install} }

    let(:expected) do
      ['arg1', 'arg2', { install: true }]
    end

    it 'returns the correct arguments and options' do
      expect(klass.parse_options!(arguments)).to be_eql(expected)
    end
  end
end
