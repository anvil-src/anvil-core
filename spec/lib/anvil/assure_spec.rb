require 'spec_helper'

describe Anvil::Assure do
  subject { dummy_assure.new }

  context 'on a passing assure' do
    let(:dummy_assure) { DummyAssure }
    it                 { should be_assured }
  end

  context 'on a non passing assure' do
    let(:dummy_assure) { DummyFailedAssure }
    it                 { should_not be_assured }
  end
end
