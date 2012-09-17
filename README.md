# ReloaderGem

    Reload gem when we change content of gem.

## Installation

Add this line to your application's Gemfile:

    gem 'reloader_gem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reloader_gem

## Usage

    require "reloader_gem"

Reload gem name_of_gem

    ReloaderGem.new(name_of_gem).listen

If you know full path into gem

    ReloaderGem.new(path_of_gem).listen

Setting the frequency of checking Gemu (in seconds)

    ReloaderGem.new(name_of_gem, 0.5).listen

Load the files defined in gem but not 'require'

    ReloaderGem.new(path_of_gem, 0.1).load("lib/reloader_gem_spec/*.rb").listen
