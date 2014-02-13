module Alfred
  class Task
    module Repositories
      def resolve_url(url)
        if url =~ /^\w+\/\w+$/
          "git@github.com:#{url}"
        else
          url
        end
      end
    end
  end
end
