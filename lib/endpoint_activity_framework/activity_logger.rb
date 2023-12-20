# frozen_string_literal: true

require 'Logger'
require 'json'

require 'pry-nav'

class ActivityLogger
  def log(context:, error: false)
    logger = Logger.new('activity_log.log')
    logger.formatter = proc do |severity, datetime, _progname, _msg|
      { 
        datetime:,
        severity:,
        **context
      }.to_json + "\n"
    end
    error ? logger.error : logger.info
  end
end
