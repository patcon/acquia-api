module AcquiaCloudApi
  class Client
    module Sites

      def sites
        get "sites"
      end
      alias :list_sites :sites

      def site(site_name = @site_name)
        get "sites/#{site_name}"
      end

      def environments(site_name = @site_name)
        get "sites/#{site_name}/envs"
      end
      alias :list_environments :environments
      alias :list_envs         :environments
      alias :envs              :environments

      def environment(env = :dev, site_name = @site_name)
        get "sites/#{site_name}/envs/#{env}"
      end
      alias :env :environment

    end
  end
end
