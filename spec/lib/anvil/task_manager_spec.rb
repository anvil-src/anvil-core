require 'spec_helper'
require 'anvil/task_manager'

describe Anvil::TaskManager do
  describe '.all_tasks' do
    it 'returns the Anvil::Task descendants' do
      expect(::Anvil::Task).to receive(:descendants)
      described_class.all_tasks
    end
  end

  describe '.files_from_current_project' do
    let(:gemfile_path) { File.dirname(Bundler::SharedHelpers.default_gemfile) }
    let(:project_task_path) { gemfile_path + '/lib/anvil/' }

    it 'returns the task files in the path' do
      expect(described_class)
        .to receive(:files_from_path).with(project_task_path)

      described_class.files_from_current_project
    end
  end

  describe '.files_from_gems' do
    it 'asks Gem to return the anvil tasks' do
      expect(Gem).to receive(:find_latest_files).with('anvil/tasks/**/*_task.rb')
      described_class.files_from_gems
    end
  end

  describe '.load_tasks' do
    let(:all_files) { %w[file1 file2] }

    before do
      described_class.stub(:all_files).and_return(all_files)
    end

    it 'loads the files' do
      expect(described_class).to receive(:load).with(all_files[0])
      expect(described_class).to receive(:load).with(all_files[1])

      described_class.load_tasks
    end
  end
end
