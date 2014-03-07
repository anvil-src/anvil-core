require 'spec_helper'
require 'tasks/changelog_task'

describe ChangelogTask, fakefs: true do
  let(:git_history) do
    ['feature1', 'feature2']
  end

  let(:file) { 'CHANGELOG.md' }

  before do
    File.open(file, 'w') do |f|
      f.write 'foo'
    end
    File.open('VERSION', 'w') do |f|
      f.write '1.2.3'
    end

    Git.stub(:open)

    subject.stub(:git_history)
      .and_return(git_history)
  end

  it 'changes CHANGELOG.md file' do
    subject.task
    File.read(file)
  end
end
