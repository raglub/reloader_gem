# encoding: utf-8

require 'reloader_gem'

def set_method(value = "0.0.3")
  file_path = File.expand_path("../reloader_gem_spec/lib/reloader_gem_spec/load_file.rb", __FILE__)
  context = <<EOF
module ReloaderGemSpec
  def self.test
    "#{value}"
  end
end
EOF
  File.write(file_path, context)
end

def set_version(version = "0.0.1")
  file_path = File.expand_path("../reloader_gem_spec/lib/reloader_gem_spec/version.rb", __FILE__)
  context = <<EOF
module ReloaderGemSpec
  VERSION = "#{version}"
end
EOF
  File.write(file_path, context)
end

set_version
set_method

require_relative 'reloader_gem_spec/lib/reloader_gem_spec.rb'

describe ReloaderGem do
  before(:all) do
    gem_path = File.expand_path("../reloader_gem_spec", __FILE__)
    ReloaderGem.new(gem_path, 0.1).load("lib/reloader_gem_spec/load_file.rb").listen
  end

  it "should properly require gem reloader_gem_spec" do
    ReloaderGemSpec::VERSION.should eql("0.0.1")
    set_version("0.0.2")
    sleep(0.5)
    ReloaderGemSpec::VERSION.should eql("0.0.2")
  end

  it "should properly load files from gem" do
    ReloaderGemSpec::test.should eql("0.0.3")
    set_method("0.0.4")
    sleep(0.5)
    ReloaderGemSpec.test.should eql("0.0.4")
  end

end
