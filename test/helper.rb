require 'rubygems'
require 'bundler'
require 'fakeweb'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'firstfm'

Firstfm.configure do |ffm|
  ffm.api_key = "TEST"
end

class Test::Unit::TestCase
end

