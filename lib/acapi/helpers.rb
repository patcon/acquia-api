module AcquiaCloudApi
  module Helpers

    def nth_fib(n)
      return n if (0..1).include? n
      nth_fib(n-1) + nth_fib(n-2) if n > 1
    end

  end
end
