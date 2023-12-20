# frozen_string_literal: true

require_relative 'endpoint_activity_framework/version'
require_relative 'endpoint_activity_framework/endpoint_activity_CLI'
require_relative 'endpoint_activity_framework/platform_identifier'

require 'pry-nav'

module EndpointActivityFramework
  class Error < StandardError; end
  EndpointActivityCLI.start(ARGV)
end
