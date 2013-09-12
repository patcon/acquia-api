module AcquiaCloudApi
  module Helpers

    def nth_fibonacci(n)
      return n if (0..1).include? n
      nth_fibonacci(n-1) + nth_fibonacci(n-2) if n > 1
    end

  end
end
