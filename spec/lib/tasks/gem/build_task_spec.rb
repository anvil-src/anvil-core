require 'spec_helper'
require 'tasks/gem/build_task'

describe Gem::BuildTask do
  let(:output) do
    <<-END
  Successfully built RubyGem
  Name: anvil
  Version: 2.0.0
  File: anvil-2.0.0.gem
  END
  end
  let(:gemspec_file) { 'anvil.gemspec' }
  let(:options) { {} }

  subject { Gem::BuildTask.new(gemspec_file, options) }

  describe '#task' do
    before do
      expect(subject).to receive(:build_gem).and_return('anvil-2.0.0.gem')
    end

    context 'without install or no-install option' do
      it 'calls #install_gem' do
        expect(Anvil::Rubygems).to receive(:install)

        expect(subject.task).to be_eql('anvil-2.0.0.gem')
      end
    end

    context 'with install: false option' do
      let(:options) { { install: false } }

      it 'doenst call install_gem ' do
        expect(Anvil::Rubygems).to_not receive(:install_gem)

        subject.task
      end
    end
  end

  describe '#extract_gem_file' do
    it 'extracts the gem file' do
      expect(subject.extract_gem_file(output)).to be_eql('anvil-2.0.0.gem')
    end
  end

  describe '#build_gem', fakefs: true do
    let(:gem_file) { 'alfred.gem' }

    before do
      allow(Anvil::Rubygems).to receive(:build) do
        FileUtils.touch('anvil-2.0.0.gem')

        output
      end
    end

    it 'builds the gem' do
      subject.build_gem(gem_file)

      expect(File.exists?('pkg/anvil-2.0.0.gem')).to be_truthy
    end

    it 'returns the gem file path' do
      expect(subject.build_gem(gem_file)).to include('/pkg/anvil-2.0.0.gem')
    end
  end

  describe '.parse_options!' do
    context 'with install option' do
      let(:arguments) { ['anvil.gem', '--install'] }

      it 'returns the correct arguments' do
        expect(Gem::BuildTask.parse_options!(arguments))
          .to be_eql(['anvil.gem', { install: true }])
      end
    end

    context 'with --no-install option' do
      let(:arguments) { ['anvil.gem', '--no-install'] }

      it 'returns the correct arguments' do
        expect(Gem::BuildTask.parse_options!(arguments))
          .to be_eql(['anvil.gem', { install: false }])
      end
    end
  end
end
