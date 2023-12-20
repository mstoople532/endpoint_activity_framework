# frozen_string_literal: true

require 'Open3'
require 'etc'


require 'pry-nav'

class UnixTrigger
  def self.create_process(path)
    # handle error
    stdin, stdout, stderr, thr = Open3.popen3(path)
    pid = thr[:pid]
    err = stderr.read
    abs_path = current_absolute_path(path)

    if err.empty?
      log(context: { method: 'create_process', path: abs_path, pid:, user: })
      stdout.read.chomp!
    else
      log(context: { method: 'create_process', msg: err }, error: true)
    end

    stdin.close
    stdout.close
  end

  def self.new_file(path)
    stdin, stdout, stderr, thr = Open3.popen3("touch #{path}")
    pid = thr[:pid]
    err = stderr.read
    abs_path = current_absolute_path(path)
    if err.empty?
      log(context: { method: 'new_file', path: abs_path, pid:, user: })
      stdout.read.chomp!
    else
      log(context: { method: 'new_file', msg: err }, error: true)
    end

    stdin.close
    stdout.close
  end

  def self.modify_file(path, string)
    stdin, stdout, stderr, thr = Open3.popen3("echo #{string} >>  #{path}")
    pid = thr[:pid]
    err = stderr.read
    abs_path = current_absolute_path(path)

    if err.empty?
      log(context: { method: 'modify_file', path: abs_path, pid:, user: })
      stdout.read.chomp!
    else
      log(context: { method: 'modify_file', msg: err }, error: true)
    end

    stdin.close
    stdout.close
  end

  def self.delete_file(path)
    stdin, stdout, stderr, thr = Open3.popen3("rm #{path}")
    pid = thr[:pid]
    err = stderr.read
    abs_path = current_absolute_path(path)

    if err.empty?
      log(context: { method: 'delete_file', path: abs_path, pid:, user: })
      stdout.read.chomp!
    else
      log(context: { method: 'delete_file', msg: err }, error: true)
    end

    stdin.close
    stdout.close
  end

  def self.establish_connection(destination_host, destination_port, source_port)
    stdin, stdout, stderr, thr = Open3.popen3("nc -v -p #{source_port} -w 2 #{destination_host} #{destination_port}")
    pid = thr[:pid]
    msg = stderr.read.chomp!

    if thr.value.success?
      log(context: { method: 'establish_connection', user:, protocol: 'tcp', destination_host:, destination_port:, source_port:, msg: })
    else
      log(context: { method: 'establish_connection', user:, pid:, msg: }, error: true)
    end

    stdin.close
    stdout.close
  end

  def self.log(context:, error: false)
    ActivityLogger.new.log(context:, error:)
  end

  def self.current_absolute_path(path)
    Open3.capture2("realpath #{path}")[0].chomp!
  end

  def self.user
    Etc.getlogin
  end
end
