require 'net/https'

class AQCloud
  attr_reader :last_response
  attr_accessor :parallel, :username, :password, :shortname

  def initialize(shortname, username, password)
    @shortname = shortname
    @username = username
    @password = password
    @last_response = false
    @parallel = false
    @tids = []
  end

  def add_db(db)
    ps "Instructing Acquia to create a new database named '#{db}'..."
    tid = do_post('dbs', {}, {'db' => db})['id']
    if last_ok?
      handle_task(tid)
    end
  end

  def copy_db(from, to, db)
    ps "Instructing Acquia to copy the #{db} database from #{from} to #{to}..."
    tid = do_post("dbs/#{db}/db-copy/#{from}/#{to}")['id']
    if last_ok?
      handle_task(tid)
    end
  end

  def copy_files(from, to)
    ps "Instructing Acquia to copy all files directories from #{from} to #{to}..."
    tid = do_post("files-copy/#{from}/#{to}")['id']
    if last_ok?
      handle_task(tid)
    end
  end

  def deploy(to_env, ref = 'production')
    ps "Instructing Acquia to deploy #{ref} to #{to_env}..."
    tid = do_post("envs/#{to_env}/code-deploy", {'path' => ref})["id"]
    if last_ok?
      handle_task(tid)
    end
  end

  def add_domain(to_env, domain)
    # TODO handle cases where domain already exists...somehow?
    ps "Instructing Acquia to add domain '#{domain}' to environment #{to_env}..."
    tid = do_post("envs/#{to_env}/domains/#{domain}")['id']
    if last_ok?
      handle_task(tid)
    end
  end

  def poll_task(tid)
    i = 0

    resp = @last_response
    until do_get("tasks/#{tid}")["state"] == "done" || (i += 1) > 30 do
      sleep(4)
    end
    @last_response = resp

    raise "Job #{tid} did not complete after 120 seconds of polling." if i > 30
  end

  def poll_all
    ps "Polling all enqueued tasks for completion." unless @tids.empty?
    while tid = @tids.pop
      poll_task(tid)
    end
  end

  def flush_queued_tasks
    @tids = []
  end

  def do_get(endpoint, params = {})
    return call(Net::HTTP::Get.new(get_path(endpoint, params)))
  end

  def do_post(endpoint, params = {}, data = {})
    return call(Net::HTTP::Post.new(get_path(endpoint, params)), data)
  end

  def do_delete(endpoint, params = {}, data = {})
    return call(Net::HTTP::Delete.new(get_path(endpoint, params)), data)
  end

  def last_ok?
    # TODO this could blow up if called before a request is issued
    return @last_response.code == '200'
  end

  protected

  def call(request, data = {})
    set_up_http unless instance_variable_defined? '@http'

    # Add any data as json-encoded POST body data
    unless data.empty?
      request.body = data.to_json
      request['Content-Type'] = 'application/json;charset=utf-8'
      request['Content-Length'] = request.body.length
    end

    request.basic_auth(@username, @password)

    @last_response = @http.request(request)

    #raise "Cloud API returned with status code #{response.code} and body '#{response.body}'." if response.code =~ /^4\d\d/
    # Parse to JSON if we can; if not, then just pass the response straight back.
    begin
      output = JSON::parse(@last_response.body)
    rescue
      output = @last_response.body
    end

    return output
  end

  def get_path(endpoint, params = {})
    path = endpoint.empty? ? "/v1/sites/#{@shortname}.json" : "/v1/sites/#{@shortname}/#{endpoint}.json"
    # Add any params via the query string
    unless params.empty?
      path << '?' << params.map{|k,v| "#{k}=#{v}"}.join('&')
    end

    return path
  end

  def handle_task(tid)
    @parallel ? @tids.push(tid) : poll_task(tid)
  end

  def set_up_http
    @http = Net::HTTP.new('cloudapi.acquia.com', 443)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    @http.cert = OpenSSL::X509::Certificate.new(File.read('cloudapi.acquia.com.pem'))
    @http.start
  end
end

