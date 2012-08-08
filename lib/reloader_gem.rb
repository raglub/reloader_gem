# encoding: utf-8

require "reloader_gem/version"
require "digest/md5"
require "logger"

class ReloaderGem

  def initialize(gem_name, time = 0.5)
    @logger = Logger.new(STDOUT)
    @gem_name = gem_name
    @gem_dir = Gem::Specification.find_by_name(@gem_name).gem_dir
    @check_sum = md5_gem
    @time = time
    run
  end

private

  def run
    Thread.new do
      while true
        sleep @time
        begin
          check_sum = md5_gem
          unless check_sum == @check_sum
            @check_sum = check_sum
            $".delete_if{|item| item.include?(@gem_name)}
            require @gem_name
            @logger.info "----- updated gem #{@gem_name} -----"
          end
        rescue
          @logger.info "----- not updated gem #{@gem_name} -----"
        end
      end
    end
  end

  def md5_gem
    result = ""
    Dir["#{@gem_dir}/**/*.rb"].each do |path|
      result << Digest::MD5.hexdigest(File.read(path))
    end
    result
  end

end
