require 'spec_helper'
require 'tasks/projects/list_task'
require 'fileutils'

describe Projects::ListTask do
  let(:projects) { %w[a b c] }

  describe '#task', config: true do
    let(:base) { Anvil::Config.base_projects_path }

    before do
      projects.each { |p| FileUtils.mkdir_p(base + "/#{p}") }
    end

    it 'list the projects in the projects path' do
      expect(subject).to receive(:list_projects).with(projects)
      subject.task
    end
  end
end
