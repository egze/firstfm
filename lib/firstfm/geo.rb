module Firstfm
  
  class Geo
    
    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :xml
    
    def self.get_events(params = {})
      location = params.delete(:location)
      lat = params.delete(:lat)
      lng = params.delete(:lng)
      page = params.delete(:page)
      distance = params.delete(:distance)
      
      response = get("/2.0/", {:query => {:method => 'geo.getevents', :location => location, :page => page, :lat => lat, :lng => lng, :distance => distance, :api_key => Firstfm::CONFIG['api_key']}})
      events = response && response['lfm'] ? Event.init_events_from_hash(response['lfm']) : []
    end
    
  end
  
end