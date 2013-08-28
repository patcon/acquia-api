module AcquiaCloudApi
  class Client
    module Files

      def copy_files!(from_env, to_env)
        post "/sites/#{@site_name}/files-copy/#{from_env}/#{to_env}"
      end

    end
  end
end
