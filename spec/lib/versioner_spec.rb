require 'spec_helper'
require 'anvil/versioner'

describe Anvil::Versioner do
  subject { described_class.new('1.2.3-pre1+build2') }
  
  describe '#major!' do
    context 'changing the major term' do
      it 'changes the major version and resets the others' do
        subject.major!.should == '2.0.0'
      end
    end
  end

  describe '#minor!' do
    context 'changing the minor term' do
      it 'changes minor term and resets patch, pre and build' do
        subject.minor!.should == '1.3.0'
      end
    end
  end

  describe '#patch!' do
    context 'changing the patch term' do
      it 'changes the patch term and resets the pre and build' do
        subject.patch!.should == '1.2.4'
      end
    end
  end

  describe '#increment!' do
    context 'if the term doesnt exist' do
      it 'raise an exception' do
        expect do
          subject.increment!(:foo)
        end.to raise_error(Anvil::Versioner::NotSupportedTerm)
      end
    end
  end
end
