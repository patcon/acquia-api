module AcquiaCloudApi
  class Client
    module Keys

      def keys
        get "sites/#{site_name}/sshkeys"
      end
      alias :list_keys :keys

      def key(key_id)
        get "sites/#{site_name}/sshkeys/#{key_id}"
      end
      alias :user_key :key

      def remove_key(key_id)
        delete "sites/#{site_name}/sshkeys/#{key_id}"
      end

      def add_key(nickname, pub_key_contents)
        params = {:nickname => nickname}
        data = {:ssh_pub_key => pub_key_contents}.to_json

        post "sites/#{site_name}/sshkeys", params, data
      end
    end
  end
end
