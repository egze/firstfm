module Firstfm
  
  class Event
    
    attr_accessor :id, :title, :url, :venue, :tag, :description, :attendance, :website, :start_date, :reviews, :artists, :headliner, :tags, :images
    
    def self.init_events_from_hash(hash)
      return [] unless hash["events"] && hash["events"]["event"]
      return [init_event_from_hash(hash["events"]["event"])] if hash["events"]["event"].is_a?(Hash)
      
      hash["events"]["event"].inject([]) do |arr, venue_hash|
        arr << init_event_from_hash(venue_hash)
        arr
      end
    end
    
    def self.init_event_from_hash(hash)
      return nil unless hash.is_a?(Hash)
      event = Event.new
      event.id = hash["id"]
      event.title = hash["title"]
      event.url = hash["url"]
      event.tag = hash["tag"]
      event.venue = Venue.init_venue_from_hash(hash["venue"])
      event.description = hash["description"]
      event.attendance = hash["attendance"]
      event.reviews = hash["reviews"]
      event.website = hash["website"]
      event.start_date = hash['startDate']
      event.artists = hash['artists']['artist'] if hash['artists']
      event.headliner = hash['artists']['headliner'] if hash['artists']
      event.tags = hash["tags"]["tag"] if hash["tags"]
      event.images = hash["image"]
      event
    end
    
  end
  
end