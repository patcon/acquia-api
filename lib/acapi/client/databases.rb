module AcquiaCloudApi
  class Client
    module Databases

      def databases(env = nil)
        if env
          get "sites/#{site_name}/envs/#{env}/dbs"
        else
          get "sites/#{site_name}/dbs"
        end
      end
      alias :list_databases :databases

      def database(db_name, env = nil)
        if env
          get "sites/#{site_name}/envs/#{env}/dbs/#{db_name}"
        else
          get "sites/#{site_name}/dbs/#{db_name}"
        end
      end

      def copy_database!(db_name, from_env, to_env)
        post "sites/#{site_name}/dbs/#{name}/db-copy/#{from_env}/#{to_env}"
      end

      def create_database(db_name)
        params = {}
        data = {:db => db_name}.to_json

        post "sites/#{site_name}/dbs", params, data
      end

      def delete_database!(db_name, backup = true)
        params = {:backup => backup ? 1 : 0}

        delete "sites/#{site_name}/dbs/#{db_name}", params
      end

    end
  end
end
