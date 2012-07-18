# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "firstfm"
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aleksandr Lossenko"]
  s.date = "2012-07-18"
  s.description = "Firstfm is a ruby wrapper for the Last.fm APIs ( http://www.last.fm/api ). My main focus is to import events from Last.FM, but with time I will try to add support for all API methods."
  s.email = "aleksandr.lossenko@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "firstfm.gemspec",
    "lib/firstfm.rb",
    "lib/firstfm/artist.rb",
    "lib/firstfm/event.rb",
    "lib/firstfm/geo.rb",
    "lib/firstfm/image.rb",
    "lib/firstfm/location.rb",
    "lib/firstfm/track.rb",
    "lib/firstfm/venue.rb",
    "test/fixtures/artist.xml",
    "test/fixtures/artists.xml",
    "test/fixtures/event.xml",
    "test/fixtures/events.xml",
    "test/fixtures/geo_event.xml",
    "test/fixtures/geo_events.xml",
    "test/fixtures/geo_get_metro_artist_chart.xml",
    "test/fixtures/get_images.xml",
    "test/fixtures/top_tracks.xml",
    "test/fixtures/tracks.xml",
    "test/fixtures/venue.xml",
    "test/fixtures/venues.xml",
    "test/helper.rb",
    "test/test_artist.rb",
    "test/test_geo.rb",
    "test/test_track.rb",
    "test/test_venue.rb"
  ]
  s.homepage = "http://github.com/egze/firstfm"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A ruby wrapper for the Last.fm APIs"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["~> 0.8"])
      s.add_runtime_dependency(%q<crack>, ["~> 0.3"])
      s.add_runtime_dependency(%q<will_paginate>, ["~> 3.0"])
      s.add_runtime_dependency(%q<chronic>, ["~> 0.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, ["~> 0.8"])
      s.add_dependency(%q<crack>, ["~> 0.3"])
      s.add_dependency(%q<will_paginate>, ["~> 3.0"])
      s.add_dependency(%q<chronic>, ["~> 0.6"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, ["~> 0.8"])
    s.add_dependency(%q<crack>, ["~> 0.3"])
    s.add_dependency(%q<will_paginate>, ["~> 3.0"])
    s.add_dependency(%q<chronic>, ["~> 0.6"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
  end
end

