class DummyTask < Alfred::Task

  def initialize(arg1 = nil, arg2 = nil, options = {})
    @arg1 = arg1
    @arg2 = arg2
    @options = options
  end

  def task; end

  def self.parse_options(arguments)
    options = {}

    OptionParser.new do |opts|
      opts.on('-a', '--argument [VALUE]') do |val|
        options[:argument] = val
      end.parse! arguments
    end

    arguments << options
    arguments
  end
end
