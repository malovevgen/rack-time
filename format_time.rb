class FormatTime
  def initialize(params)
    if params["format"]
      @params = params["format"].split(',')
    else
      @params = []
    end
  end

  def time
    if @params
      format = @params.map { |f| time_format_hash[f] }.join('-')
    else
      format = '%Y-%m-%d-%H-%M-%S' 
    end
    Time.now.strftime(format)
  end

  def valid?
    invalid_parameters.empty?
  end

  def invalid_parameters
    valid_parameters = time_format_hash.keys
    invalid_parameters = []
    @params.each do |p|
      invalid_parameters.push(p) unless valid_parameters.include?(p)
    end

    invalid_parameters
  end

  private

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
