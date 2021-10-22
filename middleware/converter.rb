class Converter

  TIMEFORMAT = { 'year'=> Time.now.year, 
                  'month'=> Time.now.month, 
                  'day'=> Time.now.day, 
                  'hour'=> Time.now.hour, 
                  'minute'=> Time.now.min, 
                  'second'=> Time.now.sec }
  
  attr_reader :params

  def initialize(params)
    @params = params.split(',')
  end

  def convert_user_format
    (@params.map { |t| TIMEFORMAT[t] }).join("-")
  end

  def invalid_params
    self.params - TIMEFORMAT.keys
  end

  def valid?
    invalid_params.empty?
  end

end
