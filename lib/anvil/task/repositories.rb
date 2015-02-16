# encoding: UTF-8

module Anvil
  class Task
    # Tools to work with github repositories
    module Repositories
      def resolve_url(url)
        if url =~ /^[\w\W]+\/[\w\W]+$/
          "git@github.com:#{url}"
        else
          url
        end
      end
    end
  end
end
