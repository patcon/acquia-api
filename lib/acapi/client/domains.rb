module AcquiaCloudApi
  class Client
    module Domains

      def domains(env)
        get "sites/#{@site_name}/envs/#{env}/domains"
      end
      alias :list_domains :domains

      def domain(domain, env)
        get "sites/#{@site_name}/envs/#{env}/domains/#{domain}"
      end

      def add_domain(domain, env)
        post "/sites/#{@site_name}/envs/#{env}/domains/#{domain}"
      end

      def remove_domain(domain, env)
        delete "sites/#{@site_name}/envs/#{env}/domains/#{domain}"
      end

      def purge_varnish_cache(domain, env)
        delete "sites/#{@site_name}/envs/#{env}/domains/#{domain}/cache"
      end
      alias :purge_varnish :purge_varnish_cache
      alias :purge_cache   :purge_varnish_cache

    end
  end
end
