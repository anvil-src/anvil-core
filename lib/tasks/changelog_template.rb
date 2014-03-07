class ChangelogTemplate
  def self.render(*args)
    new(*args).render
  end

  attr_reader :version, :history

  def initialize(current_changelog, version, history)
    @current_changelog = current_changelog
    @version = version
    @history = history
  end

  def template_path
    File.expand_path(File.dirname(__FILE__) + '/templates/changelog.erb')
  end

  def actual_date
    Time.new.strftime('%d %B %Y %H:%M')
  end

  def public_binding
    binding
  end

  def render
    template = ERB.new(File.read(template_path), 0, '%<>')
    template.result(public_binding)
  end
end
