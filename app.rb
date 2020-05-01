class Application
  def call(env)
    request = Rack::Request.new(env)
    if request.path == "/time" && request.get?
      time_response(get_parameters(request))
    else
      not_found
    end
  end

  private

  def not_found
    [404, headers, ['Not found']]
  end

  def time_response(parameters)
    invalid_parameters = invalid_params(parameters)
    if invalid_parameters.empty?
      [200, headers, [time(parameters)]]
    else
      [400, headers, ["Unknown time format [#{invalid_parameters.join(', ')}]"]]
    end
  end

  def get_parameters(request)
    params = request.params["format"]
    if params
      params.split(',')
    else
      []
    end
  end

  def headers
    { "Content-Type" => "text/plain" }
  end

  def time(format_param)
    if format_param
      format = format_param.map { |f| time_format_hash[f] }.join('-')
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

  def invalid_params(parameters)
    valid_parameters = ['year', 'month', 'day', 'hour', 'minute', 'second']
    invalid_parameters = []
    parameters.each do |p|
      invalid_parameters.push(p) unless valid_parameters.include?(p)
    end

    invalid_parameters
  end
end
