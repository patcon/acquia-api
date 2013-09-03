module AcquiaCloudApi
  class Client
    module Domains

      def domains(env)
        get "sites/#{site_name}/envs/#{env}/domains"
      end
      alias :list_domains :domains

      def domain(domain, env)
        get "sites/#{site_name}/envs/#{env}/domains/#{domain}"
      end

      def add_domain(domain, env)
        post "/sites/#{site_name}/envs/#{env}/domains/#{domain}"
      end

      def remove_domain(domain, env)
        delete "sites/#{site_name}/envs/#{env}/domains/#{domain}"
      end

      def purge_varnish_cache(domain, env)
        delete "sites/#{site_name}/envs/#{env}/domains/#{domain}/cache"
      end
      alias :purge_varnish :purge_varnish_cache
      alias :purge_cache   :purge_varnish_cache

      def migrate_domains(domains, from_env, to_env)
        domains = domains.split if domains.is_a? String

        params = {}
        data = {:domains => domains}.to_json

        post "sites/#{site_name}/domain-move/#{from_env}/#{to_env}", params, data
      end

    end
  end
end
