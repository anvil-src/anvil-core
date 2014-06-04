module Anvil
  module Config
    config_context :github do
      configurable :user
      configurable :token
    end
  end
end
