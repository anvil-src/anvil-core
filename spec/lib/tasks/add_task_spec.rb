require 'spec_helper'
require 'tasks/add_task'

describe AddTask do
  let(:repo) { 'http://repo.com/alfred/tasks' }

  subject { AddTask.new(repo) }

  describe '#task' do
    it 'clones the repo and installs' do
      subject.should_receive(:clone_repo).with(repo, 'tasks')
      subject.should_receive(:install).with('tasks')

      subject.task
    end
  end

  describe '#clone_repo' do
    before { Alfred::Config.init }

    it 'clones the repo with Git' do
      Git.should_receive(:clone).with(repo, 'tasks')
      subject.clone_repo(repo, 'tasks')
    end
  end

  describe '#install' do
    context 'if the repo has gemspec' do
      let(:gemspec_file_path) do
        "#{Alfred::Config.base_tasks_path}/alfred.gemspec"
      end
      before { subject.stub(:gemspec).and_return(gemspec_file_path) }

      it 'calls GemBuildTask.run' do
        GemBuildTask.should_receive(:run).with(gemspec_file_path)
        subject.install('alfred')
      end
    end
  end

  describe '#resolve_url' do
    let(:expected_url) { 'git@github.com:alfred/alfred' }

    context 'for a account/repo format' do
      let(:repo) { 'alfred/alfred' }
      it 'returns a github url' do
        expect(subject.resolve_url(repo)).to be_eql(expected_url)
      end
    end

    context 'for a full url format' do
      let(:repo) { 'git@github.com:alfred/alfred' }
      it 'returns the same url' do
        expect(subject.resolve_url(repo)).to be_eql(expected_url)
      end
    end
  end
end
