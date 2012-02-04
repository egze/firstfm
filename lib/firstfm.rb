require 'yaml'
require 'crack'
require 'httparty'
require 'chronic'
require 'will_paginate/collection'
require 'firstfm/track'
require 'firstfm/image'
require 'firstfm/artist'
require 'firstfm/event'
require 'firstfm/location'
require 'firstfm/venue'
require 'firstfm/geo'

module Firstfm
  
  CONFIG = YAML::load(File.read(File.join(ENV['HOME'], '.firstfm')))
  
end