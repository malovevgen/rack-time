require 'rack'

class Application
  def call(env)
    [200, {'Content-Type' => 'text/plain' }, [Time.now.to_s]]
  end
end

Rack::Handler::WEBrick.run(Application.new)