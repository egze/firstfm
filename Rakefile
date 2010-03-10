require 'rake'

begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "firstfm"
    gemspec.summary = "A ruby wrapper for the Last.fm APIs"
    gemspec.description = "Firstfm is a ruby wrapper for the Last.fm APIs ( http://www.last.fm/api ). My main focus is to import events from Last.FM, but with time I will try to add support for all API methods."
    gemspec.email = "aleksandr @nospam@ cligs.ee"
    gemspec.homepage = "http://github.com/egze/firstfm"
    gemspec.authors = ["Aleksandr Lossenko"]
    gemspec.files = FileList['lib/**/*.rb']
    
    gemspec.add_dependency 'will_paginate', '>= 2.3.12'
    gemspec.add_dependency 'httparty', '>= 0.5.2'
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end