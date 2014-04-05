require 'spec_helper'
require 'anvil/versioner'

describe Anvil::Versioner do
  subject { described_class.new('1.2.3-alpha.1+build.2') }

  describe '#major!' do
    it 'bumps the major version and resets the others' do
      subject.major!.should == '2.0.0'
    end
  end

  describe '#minor!' do
    it 'bumps minor term and resets patch, pre and build' do
      subject.minor!.should == '1.3.0'
    end
  end

  describe '#patch!' do
    it 'bumps the patch term and resets the pre and build' do
      subject.patch!.should == '1.2.4'
    end
  end

  describe '#pre' do
    it 'bumps the pre-release version and resets the build' do
      subject.pre!.should == '1.2.3-alpha.2'
    end
  end

  describe '#build!' do
    it 'bumps the build version' do
      subject.build!.should == '1.2.3-alpha.1+build.3'
    end
  end

  describe '#increment!' do
    context 'if the term doesnt exist' do
      it 'raise an exception' do
        expect do
          subject.bump!(:foo)
        end.to raise_error(Anvil::Versioner::NotSupportedTerm)
      end
    end
  end
end
