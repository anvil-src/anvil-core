class DummyTask < Alfred::Task
  def task; end

  def self.parse_options(arguments)
    options = {}

    OptionParser.new do |opts|
      opts.on('-a', '--argument [VALUE]') do |val|
        options[:argument] = val
      end.parse! arguments
    end

    options
  end
end
