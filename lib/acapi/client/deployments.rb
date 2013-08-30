module AcquiaCloudApi
  class Client
    module Deployments

      def deploy_reference!(git_ref, to_env)
        params = {
          :path => git_ref
        }
        post "sites/#{site_name}/envs/#{to_env}/code-deploy", params
      end
      alias :deploy!     :deploy_reference!
      alias :deploy_ref! :deploy_reference!

    end
  end
end
