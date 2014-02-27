require 'spec_helper'

describe Anvil::DirectoryAssure do
  context 'with an existing directory' do
    before { FileUtils.mkdir('dummy_dir') }

    it { should be_assured('dummy_dir') }
  end

  context 'with a non existing directory' do
    it { should_not be_assured('dummy_dir') }
  end

  context 'with a file' do
    before { FileUtils.touch('dummy_file') }

    it { should_not be_assured('dummy_file') }
  end
end
