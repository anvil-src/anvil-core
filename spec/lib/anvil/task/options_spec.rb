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
    end
  end

  describe '.build_parser' do
    it 'returns an instance of Anvil::Parser' do
      expect(klass.build_parser).to be_kind_of(Anvil::Parser)
    end
  end

  describe '.parse_options!' do
    context 'with more than one argument and options' do
      before do
        klass.class_eval do
          parser do
            arguments %w(arg1 arg2)
            on('-i', '--install') do |i|
              options[:install] = i
            end
          end
        end
      end
      let(:arguments) { %w(arg1 arg2 --install) }
      let(:expected)  { ['arg1', 'arg2', { install: true }] }

      it 'returns the correct arguments and options' do
        expect(klass.parse_options!(arguments)).to be_eql(expected)
      end
    end

    context 'with one argument and options' do
      before do
        klass.class_eval do
          parser do
            arguments %w(arg1)
            on('-i', '--install') do |i|
              options[:install] = i
            end
          end
        end
      end
      let(:arguments) { %w{arg1 --install} }
      let(:expected)  { ['arg1', { install: true }] }

      it 'returns the correct arguments and options' do
        expect(klass.parse_options!(arguments)).to be_eql(expected)
      end
    end

    context 'only with one argument' do
      let(:arguments) { %w(arg1) }
      let(:expected)  { arguments }
      let(:parser_block) do
        proc do
          arguments %w(arg1)
        end
      end

      it 'returns the correct arguments and options' do
        expect(klass.parse_options!(arguments)).to be_eql(expected)
      end
    end
  end
end
