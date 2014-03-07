require 'spec_helper'

describe Anvil::FileAssure, fakefs: true do
  context 'with an existing file' do
    before { FileUtils.touch 'dummy_file.txt' }
    after  { FileUtils.rm 'dummy_file.txt' }

    it { should be_assured('dummy_file.txt') }
  end

  context 'with a non existing file' do
    it { should_not be_assured('dummy_file.txt') }
  end
end
