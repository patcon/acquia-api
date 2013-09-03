module AcquiaCloudApi
  class Client
    module Sites

      def sites
        get "sites"
      end
      alias :list_sites :sites

      def site(name = site_name)
        get "sites/#{name}"
      end

      def environments(name = site_name)
        get "sites/#{name}/envs"
      end
      alias :list_environments :environments
      alias :list_envs         :environments
      alias :envs              :environments

      def environment(env = :dev, name = site_name)
        get "sites/#{name}/envs/#{env}"
      end
      alias :env :environment

    end
  end
end
