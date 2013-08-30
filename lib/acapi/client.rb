require 'json'
require 'rest_client'
require 'acapi/default'
require 'acapi/client/databases'
require 'acapi/client/deployments'
require 'acapi/client/domains'
require 'acapi/client/files'
require 'acapi/client/keys'
require 'acapi/client/servers'
require 'acapi/client/sites'
require 'acapi/client/tasks'

module AcquiaCloudApi
  class Client
    include AcquiaCloudApi::Client::Databases
    include AcquiaCloudApi::Client::Deployments
    include AcquiaCloudApi::Client::Domains
    include AcquiaCloudApi::Client::Files
    include AcquiaCloudApi::Client::Keys
    include AcquiaCloudApi::Client::Servers
    include AcquiaCloudApi::Client::Sites
    include AcquiaCloudApi::Client::Tasks

    def initialize(options = {})
      @options = options
      @site_name = options[:site_name]
      @last_response = false
    end

    def get(uri, params = {})
      request :get, uri, params
    end

    def post(uri, params = {}, data = {})
      request :post, uri, params, data
    end

    def delete(uri, params = {})
      request :delete, uri, params
    end

    def site_name
      @site_name ||= Client.new(@options).sites.first.split(':').last
    end

    private

    def request(method, uri, params = {}, data = {})
      cert = OpenSSL::X509::Certificate.new(File.read("#{AcquiaCloudApi.source_root}/cloudapi.acquia.com.pem"))

      req = RestClient::Request.new(
        :method => method,
        :url => "#{Default::API_ENDPOINT}/#{uri}.json",
        :user => @options[:username],
        :password => @options[:password],
        :payload => data,
        :ssl_client_cert => cert,
        :headers => {
          :params => params
        }
      )

      res = req.execute
      @last_response = res

      JSON.parse(res)
    end

  end
end
