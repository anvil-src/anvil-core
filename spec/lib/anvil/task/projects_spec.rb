require 'spec_helper'
require 'anvil/task/projects'

describe Anvil::Task::Projects, fakefs: true do
  let(:dummy_class) do
    Class.new do
      include Anvil::Task::Projects
    end
  end
  let(:project) { 'anvil-core' }
  let(:project_path) { Anvil::Config.base_projects_path + "/#{project}" }
  subject { dummy_class.new }

  before { FileUtils.mkdir_p project_path }

  describe '#project_path' do
    it "returns the anvil's project path" do
      expect(subject.project_path(project))
        .to eq(project_path)
    end
  end

  describe '#change_project' do
    let!(:previous_dir) { Dir.getwd }

    before { FileUtils.mkdir_p project_path }
    after { Dir.chdir previous_dir }

    it "cd's into the project's path" do
      subject.change_project(project)
      expect(Dir.getwd).to eq(project_path)
    end
  end

  describe '#on_project' do
    before { subject.stub(:git).and_return(double('git')) }

    it 'keeps the project changed inside the block' do
      subject.on_project project do
        expect(Dir.pwd).to eq(project_path)
      end
    end

    it 'yields a git project object' do
      expect { |b| subject.on_project(project, &b) }.to yield_with_args
    end
  end

  describe '#on_each_project' do
    let(:projects) { %w(anvil-core anvil-plugins) }
    before do
      expect(subject).to receive(:on_project).twice.and_yield(double('git'))
    end

    it 'works on each project' do
      expect { |b| subject.on_each_project(projects, &b) }.to yield_control.twice
    end
  end
end
