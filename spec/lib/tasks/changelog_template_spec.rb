require 'spec_helper'
require 'tasks/changelog_template'

describe ChangelogTemplate do
  subject { described_class.new('', '', '') }

  describe '#template_path' do
    it 'returns a existing file' do
      expect(File).to exist(subject.template_path)
    end
  end
end
