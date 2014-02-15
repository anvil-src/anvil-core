require 'alfred/task'

class HelpTask < Alfred::Task
  description 'Help for the alfred tasks. Usage: alfred help TASK'

  parser do
    arguments %w[task]
  end

  attr_reader :task

  def initialize(task, options = {})
    @task = task
  end

  def task
    klazz = Alfred::Task.from_name(task)
    printf(klazz.help)
  end
end
