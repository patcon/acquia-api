module AcquiaCloudApi
  class Client
    module Databases

      def sites
        get "sites"
      end
      alias :list_sites :sites

      def copy_database!(db_name, from_env, to_env)
        post "sites/#{@site_name}/dbs/#{name}/db-copy/#{from_env}/#{to_env}"
      end

      def create_database(db_name, options = {})
        params = {}
        data = {
          :db => name,
          :options => options
        }

        post "sites/#{@site_name}/dbs", params, data
      end

    end
  end
end
