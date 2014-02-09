require 'spec_helper'
require 'tasks/gem_build_task'

describe GemBuildTask do
  let(:output) do
    <<-END
  Successfully built RubyGem
  Name: alfred
  Version: 2.0.0
  File: alfred-2.0.0.gem
  END
  end
  let(:gemspec_file) { 'alfred.gemspec' }
  let(:options) { {} }

  subject { GemBuildTask.new(gemspec_file, options) }

  describe '#task' do
    before do
      expect(subject).to receive(:build_gem).and_return('alfred-2.0.0.gem')
    end

    context 'without install or no-install option' do
      it 'calls #install_gem' do
        expect(subject).to receive(:install_gem)

        expect(subject.task).to be_eql('alfred-2.0.0.gem')
      end
    end

    context 'with install: false option' do
      let(:options) { { install: false } }

      it 'doenst call install_gem ' do
        expect(subject).to_not receive(:install_gem)

        subject.task
      end
    end
  end

  describe '#extract_gem_file' do
    it 'extractts the gem file' do
      expect(subject.extract_gem_file(output)).to be_eql('alfred-2.0.0.gem')
    end
  end

  describe '#build_gem' do
    let(:gem_file) { 'alfred.gem' }
    before do
      subject.stub(:command) do
        FileUtils.touch('alfred-2.0.0.gem')
        output
      end
    end

    it 'builds the gem' do
      subject.build_gem(gem_file)

      expect(File.exists?('pkg/alfred-2.0.0.gem')).to be_true
    end

    it 'returns the gem file path' do
      expect(subject.build_gem(gem_file)).to be_eql('/pkg/alfred-2.0.0.gem')
    end
  end

  describe '#install_gem' do
    let(:command) { 'gem install alfred' }

    it 'calls gem install' do
      expect(subject).to receive(:command).with(command)
      subject.install_gem('alfred')
    end
  end

  describe '.parse_options!' do
    context 'with install option' do
      let(:arguments) { ['alfred.gem', '--install'] }

      it 'returns the correct arguments' do
        expect(GemBuildTask.parse_options!(arguments))
        .to be_eql(['alfred.gem', { install: true }])
      end
    end

    context 'with --no-install option' do
      let(:arguments) { ['alfred.gem', '--no-install'] }

      it 'returns the correct arguments' do
        expect(GemBuildTask.parse_options!(arguments))
        .to be_eql(['alfred.gem', { install: false }])
      end
    end
  end
end
