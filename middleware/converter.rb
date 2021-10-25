class Converter

  TIME_FORMAT = {'year'=> '%Y', 'month'=> '%m', 'day'=> '%d', 'hour'=> '%H', 'minute'=> '%m', 'second'=> '%S'}
  
  attr_reader :unknown_formats

  def initialize(params)
    @params = params.split(',')
    @valid_formats = []
    @unknown_formats = []
  end

  def call
    @params.each do |f|
      if TIME_FORMAT.key?(f)
        @valid_formats << TIME_FORMAT[f]
      else
        @unknown_formats << f
      end
    end
  end

  def valid_formats
    Time.now.strftime(@valid_formats.join('-'))
  end

  def invalid_params
    @params - TIME_FORMAT.keys
  end

  def success?
    invalid_params.empty?
  end

end
