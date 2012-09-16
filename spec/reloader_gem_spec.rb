# encoding: utf-8

require 'reloader_gem'

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

require_relative 'reloader_gem_spec/lib/reloader_gem_spec.rb'

describe ReloaderGem do
  before(:each) do
    gem_path = File.expand_path("../reloader_gem_spec", __FILE__)
    ReloaderGem.new(gem_path, 0.1).run
  end

  it "should properly require gem reloader_gem_spec" do
    ReloaderGemSpec::VERSION.should eql("0.0.1")
    set_version("0.0.2")
    sleep(0.5)
    ReloaderGemSpec::VERSION.should eql("0.0.2")
  end
end
