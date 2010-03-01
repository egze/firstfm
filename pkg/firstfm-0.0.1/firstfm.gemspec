# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{firstfm}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aleksandr Lossenko"]
  s.date = %q{2010-03-01}
  s.description = %q{a ruby wrapper for the Last.fm APIs}
  s.email = %q{aleksandr @nospam@ cligs.ee}
  s.extra_rdoc_files = ["README.rdoc", "lib/firstfm.rb", "lib/firstfm/event.rb", "lib/firstfm/location.rb", "lib/firstfm/venue.rb"]
  s.files = ["README.rdoc", "Rakefile", "lib/firstfm.rb", "lib/firstfm/event.rb", "lib/firstfm/location.rb", "lib/firstfm/venue.rb", "test/fixtures/event.xml", "test/fixtures/events.xml", "test/fixtures/venue.xml", "test/fixtures/venues.xml", "test/test_helper.rb", "test/unit/venue_test.rb", "Manifest", "firstfm.gemspec"]
  s.homepage = %q{http://github.com/egze/firstfm}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Firstfm", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{firstfm}
  s.rubygems_version = %q{1.3.5}
  s.signing_key = %q{/Users/egze/gem-private_key.pem}
  s.summary = %q{a ruby wrapper for the Last.fm APIs}
  s.test_files = ["test/test_helper.rb", "test/unit/venue_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.5.2"])
      s.add_runtime_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_runtime_dependency(%q<will_paginate>, [">= 2.3.12"])
    else
      s.add_dependency(%q<httparty>, [">= 0.5.2"])
      s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
      s.add_dependency(%q<will_paginate>, [">= 2.3.12"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.5.2"])
    s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
    s.add_dependency(%q<will_paginate>, [">= 2.3.12"])
  end
end
