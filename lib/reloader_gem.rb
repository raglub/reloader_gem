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

  def run
    Thread.new do
      while true
        sleep @time
        begin
          if change_check_sum?
            require_gem
            @load_files.each do |path|
              load path
            end
          end
        rescue
          @logger.info "----- not updated gem #{@gem_name} -----"
        end
      end
    end
  end

  def load_file(path)
    @load_files << path
    self
  end
private

  def require_gem
    $".delete_if{|item| item.include?(@gem_name)}
    require File.join(@gem_path, "lib", @gem_name)
    @logger.info "----- updated gem #{@gem_name} -----"
  end

  def change_check_sum?
    check_sum = md5_gem
    return false if check_sum == @check_sum
    @check_sum = check_sum
    true
  end

  def md5_gem
    result = ""
    Dir["#{@gem_path}/**/*.rb"].each do |path|
      result << Digest::MD5.hexdigest(File.read(path))
    end
    result
  end

end
