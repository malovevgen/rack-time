class Application
  def call(env)
    request = Rack::Request.new(env)
    if request.path == "/time" && request.get?
      response = get_response(request.params)
      [response.status, headers, response.body]
    else
      not_found
    end
  end

  private

  def not_found
    [404, headers, ['Not found']]
  end

  def get_response(params)
    response = Response.new
    formatter = FormatTime.new(params)
    if formatter.valid?
      response.status = 200
      response.body = [formatter.time]
    else
      response.status = 400
      response.body = ["Unknown time format [#{formatter.invalid_parameters.join(', ')}]"]
    end

    response
  end

  def headers
    { "Content-Type" => "text/plain" }
  end
end
