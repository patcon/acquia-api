require 'faraday'
require 'faraday_middleware'

module ACAPI
  class Connection

    attr_reader :username, :password, :cert

    def self.connection
      @connection ||= Faraday.new do |builder|
        builder.request  :retry
        builder.response :logger
        builder.response :mashify
        builder.response :json
        builder.adapter  :net_http
      end
    end

    def initialize(username, password, cert)
      @cert = cert
      @uri = URI.parse('https://cloudapi.acquia.com')

      connection.basic_auth username, password
    end

    def connection
      @connection ||= begin
        conn = self.class.connection.dup
        set_connection_options(conn)
        conn
      end
    end

    def get(url)
      res = connection.get(url)
      res.body
    end

  private
    def set_connection_options(conn)
      conn.url_prefix = @uri.to_s
      conn.ssl.merge!({:cert => @cert})
    end
  end
end
