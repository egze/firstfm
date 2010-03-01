module Firstfm
  
  class Venue
    
    attr_accessor :id, :name, :url, :location, :website, :phonenumber, :images
    
    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :xml
    
    def self.search(venue, page = 1, limit = 50, country = nil)
      response = get("/2.0/", {:query => {:method => 'venue.search', :venue => venue, :page => page, :limit => limit, :country => country, :api_key => Firstfm::CONFIG['api_key']}})
      venues = response && response['lfm'] ? Venue.init_venues_from_hash(response['lfm']) : []
      collection = WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace venues
        pager.total_entries = response['lfm']['results']['opensearch:totalResults'].to_i
      end
    end
    
    def self.get_events(venue_id)
      response = get("/2.0/", {:query => {:method => 'venue.getEvents', :venue => venue_id, :api_key => Firstfm::CONFIG['api_key']}})
      events = response && response['lfm'] ? Event.init_events_from_hash(response['lfm']) : []
    end
    
    def get_events
      self.class.get_events(self.id)
    end
    
    def self.init_venues_from_hash(hash)
      return [] unless hash["results"] && hash["results"]["venuematches"] && hash["results"]["venuematches"]["venue"]
      return [init_venue_from_hash(hash["results"]["venuematches"]["venue"])] if hash["results"]["venuematches"]["venue"].is_a?(Hash)
      hash["results"]["venuematches"]["venue"].inject([]) do |arr, venue_hash|
        arr << init_venue_from_hash(venue_hash)
        arr
      end
    end
    
    def self.init_venue_from_hash(hash)
      venue = Venue.new
      venue.id          = hash["id"]
      venue.name        = hash["name"]
      venue.url         = hash["url"]
      venue.location    = Location.init_location_from_hash(hash["location"])
      venue.website     = hash["website"]
      venue.phonenumber = hash["phonenumber"]
      venue.images = hash["image"]
      venue
    end
    
  end
  
end