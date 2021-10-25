require_relative 'converter'

class Timeformat

  TIME_URL = '/time'

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    request_params = request.params['format']

    if request.path != TIME_URL
      body = request_params.nil? ? body_unknown : body_bad_url
      response(status_error, headers, body)
    else
      time_request(request_params)
    end
  end 

  private

  def time_request(request_params)

    time_formatter = Converter.new(request_params)
    time_formatter.call
    if time_formatter.success?
      response(status_success, headers, "#{time_formatter.valid_formats}\n")
    else
      response(status_error, headers, "#{time_formatter.unknown_formats}\n")
    end
  end

  def response(status, headers, body)
    response = Rack::Response.new(body, status, headers)
    response.finish
  end

  def status_error
    404
  end

  def status_success
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def  body
    ["Welcome aboard!\n"]
  end

  def  body_unknown
    ["Unknown time format\n"]
  end

  def  body_bad_url
    ["Bad url\n"]
  end

end