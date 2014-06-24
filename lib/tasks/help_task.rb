require 'anvil/task'

class HelpTask < Anvil::Task
  description 'Help for the anvil tasks. Usage: anvil help TASK'

  parser do
    arguments %w(task_name)
  end

  attr_reader :task_name

  def initialize(task_name, options = {})
    @task_name = task_name
  end

  def task
    return default_message unless task_name.present?
    klazz = Anvil::Task.from_name(task_name)
    printf(klazz.help)
  end

  def default_message
    printf(self.class.help)
  end
end
