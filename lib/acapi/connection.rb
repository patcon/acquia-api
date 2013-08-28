require 'faraday'
require 'faraday_middleware'

module ACAPI
  class Connection

    attr_reader :shortname, :username, :password, :cert

    def self.connection
      @connection ||= Faraday.new do |builder|
        builder.request  :retry
        builder.response :logger
        builder.response :mashify
        builder.response :json
        builder.adapter  :net_http
      end
    end

    def initialize(shortname, username, password, cert)
      @shortname = shortname
      @cert = cert
      @uri = URI.parse('https://cloudapi.acquia.com/v1')

      connection.basic_auth username, password
    end

    def connection
      @connection ||= begin
        conn = self.class.connection.dup
        set_connection_options(conn)
        conn
      end
    end

    def get(url, *args)
      res = connection.get(url, *args)
      res.body
    end

    def post(url, body = nil, *args)
      res = connection.post(url, body, *args)
      res.body
    end

    def task_state(task_id = nil)
      res = connection.get "/sites/#{@shortname}/tasks/#{task_id}"
      res.body
    end

  private
    def set_connection_options(conn)
      conn.url_prefix = @uri.to_s
      conn.ssl.merge!({:cert => @cert})
    end
  end
end
