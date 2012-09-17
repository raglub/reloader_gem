# encoding: utf-8

require "reloader_gem/version"
require "digest/md5"
require "logger"

class ReloaderGem

  def initialize(gem_name_path, time = 0.5)
    @logger = Logger.new(STDOUT)

    if gem_name_path.split("/").last == gem_name_path
      @gem_name = gem_name_path
      @gem_path = Gem::Specification.find_by_name(@gem_name).gem_dir
    else
      @gem_name = gem_name_path.split("/").last
      @gem_path = gem_name_path
    end

    @check_sum = md5_gem
    @time = time
    @load_files =[]
  end

  # listen the gem
  def listen
    load_files
    Thread.new do
      while true
        sleep @time
        update_files
      end
    end
  end

  # load all files from gem which match into variable regexp
  def load(regexp)
    @load_files += Dir[File.join(@gem_path, regexp)]
    self
  end

private

  # if the gem is changed,  require gem and load files?
  def update_files
    return unless changed_gem?
    require_gem
    load_files
  rescue
    @logger.info "----- not updated gem #{@gem_name} -----"
  end

  # remove old version of gem and require a new version this gem
  def require_gem
    $".delete_if{|item| item.include?(@gem_name)}
    require File.join(@gem_path, "lib", @gem_name)
    @logger.info "----- updated gem #{@gem_name} -----"
  end

  # load all files defined in variable @load_files
  def load_files
    @load_files.each do |path|
      Kernel::load path
    end
  end

  # is new version of gem?
  def changed_gem?
    check_sum = md5_gem
    return false if check_sum == @check_sum
    @check_sum = check_sum
    true
  end

  # count check sum for declared the gem
  def md5_gem
    result = ""
    Dir["#{@gem_path}/**/*.rb"].each do |path|
      result << Digest::MD5.hexdigest(File.read(path))
    end
    result
  end

end
