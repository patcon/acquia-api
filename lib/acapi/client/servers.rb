module AcquiaCloudApi
  class Client
    module Servers

      def servers(env)
        get "sites/#{site_name}/envs/#{env}/servers"
      end
      alias :list_servers :servers

      def server(server_name, env)
        get "sites/#{site_name}/envs/#{env}/servers/#{server_name}"
      end

      # TODO: Fix this (https://twitter.com/patconnolly/status/373203055677689857)
      def php_procs(server_name, env, memory_limits = [], apc_shm = [])
        memory_limits = memory_limits.split(',') if memory_limits.is_a? String
        apc_shm = apc_shm.split(',') if apc_shm.is_a? String

        params = {
          :memory_limits => memory_limits,
          :apc_shm => apc_shm
        }
        get "sites/#{site_name}/envs/#{env}/servers/#{server_name}/php-procs", params
      end

    end
  end
end
