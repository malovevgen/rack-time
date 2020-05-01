class Application
  def call(env)
    request = Rack::Request.new(env)
    if request.path == "/time" && request.get?

      [200, headers, [time(request.params["format"])]]
    else
      not_found
    end
  end

  private

  def not_found
    [404, headers, ['Not found']]
  end

  def serve_request
    Router.new(request).route!
  end

  def headers
    { "Content-Type" => "text/plain" }
  end

  def time(format_param)
    if format_param
      format = format_param.split(',').map { |f| time_format_hash[f] }.join('-')
    else
      format = '%Y-%m-%d-%H-%M-%S' 
    end
    puts format
    Time.now.strftime(format)
  end

  def time_format_hash
    {
      'year'   => '%Y',
      'month'  => '%m',
      'day'    => '%d',
      'hour'   => '%H',
      'minute' => '%M',
      'second' => '%S'
    }
  end
end
