class PlatformIdentifier
  require 'Open3'

  def self.identify_platform
    stdin, stdout, _stderr, _thr = Open3.popen3('uname')
    output = stdout.read.chomp!

    stdin.close
    stdout.close
    output
  end

  def self.macOS?
    identify_platform == 'Darwin'
  end

  def self.linux?
    identify_platform.present? && !macOS
  end

  def self.unix?
    macOS? || linux?
  end
end
