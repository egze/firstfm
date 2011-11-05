# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{firstfm}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aleksandr Lossenko"]
  s.date = %q{2011-11-05}
  s.description = %q{Firstfm is a ruby wrapper for the Last.fm APIs ( http://www.last.fm/api ). My main focus is to import events from Last.FM, but with time I will try to add support for all API methods.}
  s.email = %q{aleksandr.lossenko@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
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
    "test/fixtures/artists.xml",
    "test/fixtures/event.xml",
    "test/fixtures/events.xml",
    "test/fixtures/geo_event.xml",
    "test/fixtures/geo_events.xml",
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
  s.homepage = %q{http://github.com/egze/firstfm}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A ruby wrapper for the Last.fm APIs}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, ["= 0.7.8"])
      s.add_runtime_dependency(%q<will_paginate>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.10"])
      s.add_runtime_dependency(%q<chronic>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, ["= 0.7.8"])
      s.add_dependency(%q<will_paginate>, [">= 0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.10"])
      s.add_dependency(%q<chronic>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, ["= 0.7.8"])
    s.add_dependency(%q<will_paginate>, [">= 0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.10"])
    s.add_dependency(%q<chronic>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
  end
end

