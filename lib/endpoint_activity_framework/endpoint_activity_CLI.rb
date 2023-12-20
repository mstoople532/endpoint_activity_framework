# frozen_string_literal: true

require 'Thor'
require_relative './unix_trigger'
require_relative './activity_logger'

class EndpointActivityCLI < Thor
  option :path
  desc 'create_process <path>', 'Starts a process, given a path to an executable'
  def create_process(path)
    UnixTrigger.create_process(path) if PlatformIdentifier.unix?
  end

  option :path
  desc 'new_file <path>', 'Creates a new file, given the preferred file path'
  def new_file(path)
    UnixTrigger.new_file(path) if PlatformIdentifier.unix?
  end

  option :path
  option :string
  desc 'modify_file <path>', 'Appends a string to the preferred file'
  def modify_file(path, string)
    UnixTrigger.modify_file(path, string) if PlatformIdentifier.unix?
  end

  option :path
  desc 'delete_file <path>', 'Deletes a file, given the path to the file'
  def delete_file(path)
    UnixTrigger.delete_file(path) if PlatformIdentifier.unix?
  end

  option :destination_host
  option :destination_port
  option :source_port
  desc 'establish_connection <destination_host> <destination_port> <source_port>', 'Connects to a remote host'
  def establish_connection(destination_host, destination_port, source_port)
    UnixTrigger.establish_connection(destination_host, destination_port, source_port) if PlatformIdentifier.unix?
  end
end
