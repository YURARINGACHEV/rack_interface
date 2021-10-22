require_relative 'converter'

class Timeformat

  FORMAT = ["year", "month", "day", "hour", "minute", "second"]

  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @body = @app.call(env)    
    request_parameters(env)   
  end 

  def request_parameters(env)
    request = Rack::Request.new(env)
    path  = request.path
    request_params = request.params['format']
    formattime = Converter.new(request_params)  
    format_check(path, request_params, formattime )
  end

  def format_check(path, request_params, formattime)
    
      if path == '/time'
        if request_params.nil?
          @status = 404
          @headers['timeformat'] = "Unknown format"  
        elsif formattime.valid?
          @headers['timeformat'] = formattime.convert_user_format
        else
          @status = 400
          @headers['timeformat'] = "Unknown time format #{formattime.invalid_params}"
        end
      else
        @status = 400
        @headers['timeformat'] = "Unknown format" 
      end
      [@status, @headers, @body]
  end


end