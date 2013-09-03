require 'acapi/version'

module AcquiaCloudApi
  module Default

    API_ENDPOINT = "https://cloudapi.acquia.com/v1".freeze

    class << self

      def api_endpoint
        ENV['ACAPI_API_ENDPOINT'] || API_ENDPOINT
      end

    end
  end
end
