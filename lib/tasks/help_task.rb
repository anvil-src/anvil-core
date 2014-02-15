require 'alfred/task'

class HelpTask < Alfred::Task
  description 'Help for the alfred tasks. Usage: alfred help TASK'

  parser do
    arguments %w[task_name]
  end

  attr_reader :task_name

  def initialize(task_name, options = {})
    @task_name = task_name
  end

  def task
    klazz = Alfred::Task.from_name(task_name)
    printf(klazz.help)
  end
end
