module AcquiaCloudApi
  class Client
    module Domains

      def create_domain(domain, env)
        post "/sites/#{@site_name}/envs/#{env}/domains/#{domain}"
      end

    end
  end
end
