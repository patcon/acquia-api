require 'json'
require 'rest_client'
require 'acapi/default'
require 'acapi/client/databases'
require 'acapi/client/deployments'
require 'acapi/client/domains'
require 'acapi/client/files'
require 'acapi/client/sites'
require 'acapi/client/tasks'

module AcquiaCloudApi
  class Client
    include AcquiaCloudApi::Client::Databases
    include AcquiaCloudApi::Client::Deployments
    include AcquiaCloudApi::Client::Domains
    include AcquiaCloudApi::Client::Files
    include AcquiaCloudApi::Client::Sites
    include AcquiaCloudApi::Client::Tasks

    def initialize(options = {})
      @site_name = options[:site_name]
      @username = options[:username]
      @password = options[:password]
    end

    def get(uri, params = {})
      request :get, uri, params
    end

    def post(uri, params = {}, data = {})
      request :post, uri, params, data
    end

    private

    def request(method, uri, params = {}, data = {})
      cert = OpenSSL::X509::Certificate.new(File.read("#{AcquiaCloudApi.source_root}/cloudapi.acquia.com.pem"))

      req = RestClient::Request.new(
        :method => method,
        :url => "#{Default::API_ENDPOINT}/#{uri}.json",
        :user => @username,
        :password => @password,
        :ssl_client_cert => cert,
        :headers => {
          :params => params
        }
      )

      res = req.execute
      @last_response = res.code

      JSON.parse(res)
    end
  end
end
