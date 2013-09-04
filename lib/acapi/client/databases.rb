module AcquiaCloudApi
  class Client
    module Databases

      def databases(env=nil, db_clusters=nil)
        if env
          # db instances
          db_cluster_array = db_clusters.split if db_clusters.is_a? String

          params = {:db_cluster => db_cluster_array} unless db_clusters.nil?

          get "sites/#{site_name}/envs/#{env}/dbs", params
        else
          # db records
          get "sites/#{site_name}/dbs"
        end
      end
      alias :list_databases :databases

      def database(db_name, env=nil)
        if env
          # db instances
          get "sites/#{site_name}/envs/#{env}/dbs/#{db_name}"
        else
          # db records
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

      def delete_database!(db_name, backup=true)
        params = {:backup => backup ? 1 : 0}

        delete "sites/#{site_name}/dbs/#{db_name}", params
      end

      def database_backups(db_name, env=nil)
        get "sites/#{site_name}/envs/#{env}/dbs/#{db_name}/backups"
      end
      alias :list_backups :database_backups
      alias :backups      :database_backups

      def create_database_backup(db_name, env=nil)
        post "sites/#{site_name}/envs/#{env}/dbs/#{db_name}/backups"
      end
      alias :create_backup :create_database_backup

      def database_backup(backup_id, db_name, env=nil)
        get "sites/#{site_name}/envs/#{env}/dbs/#{db_name}/backups/#{backup_id}"
      end
      alias :backup :database_backup

      def download_database_backup(backup_id, db_name, env=nil)
        # TODO: Not working. Likely need to fix #get method so that doesn't try
        # to parse response as JSON
        get "sites/#{site_name}/envs/#{env}/dbs/#{db_name}/backups/#{backup_id}/download"
      end
      alias :download_backup :download_database_backup

      def download_database_backup_link(backup_id, db_name, env=nil)
        res = database_backup(backup_id, db_name, env)
        download_link = res['link']

        download_link
      end
      alias :download_backup_link :download_database_backup_link

      def restore_database_backup!(backup_id, db_name, env=nil)
        post "sites/#{site_name}/envs/#{env}/dbs/#{db_name}/backups/#{backup_id}/restore"
      end
      alias :restore_backup! :restore_database_backup!

    end
  end
end
