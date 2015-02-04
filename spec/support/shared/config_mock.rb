# Mocks the anvil config and folder for the specs so that it uses a
# sandbox instead of the user's one
module ConfigMock
  def self.base_path
    File.expand_path('../dot_anvil', File.dirname(__FILE__))
  end

  def self.config_file
    File.expand_path('../fixtures/config.rb', File.dirname(__FILE__))
  end
end

Anvil::Config::ClassMethods.module_eval do
  def base_path
    ConfigMock.base_path
  end
end
