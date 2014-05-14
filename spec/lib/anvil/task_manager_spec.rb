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
    let(:gemfile_path) { described_class.current_project_path }
    let(:project_task_path) { gemfile_path + '/lib/anvil/' }

    it 'returns the task files in the path' do
      expect(described_class)
        .to receive(:files_from_path).with(project_task_path)

      described_class.files_from_current_project
    end
  end

  describe '.current_project_path' do
    let(:pwd) { '/home/user/src/project/' }
    context 'on a path managed by git' do
      before do
        Rugged::Repository.stub(:discover)
          .and_return(pwd + '.git/')
      end

      it 'returns the repo workdir' do
        expect(described_class.current_project_path)
          .to eq(pwd)
      end
    end

    context 'on a path not managed by git' do
      before do
        Rugged::Repository.stub(:discover)
          .and_raise(Rugged::RepositoryError)
      end

      it 'returns an empty string' do
        expect(described_class.current_project_path)
          .to be_empty
      end
    end
  end

  describe '.files_from_gems' do
    it 'asks Gem to return the anvil tasks' do
      expect(Gem).to receive(:find_latest_files).with('anvil/tasks/**/*_task.rb')
      described_class.files_from_gems
    end
  end

  describe '.files_from_env' do
    context 'with empty env variable' do
      it 'returns an empty array' do
        expect(described_class.files_from_env).to eq([])
      end
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
