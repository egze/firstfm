module Firstfm
  
  class Track
    
    attr_accessor :name, :artist, :url, :streamable, :listeners, :images, :mbid, :rank
   
    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :xml
    
    def self.search(track, page = 1, limit = 30)
      response = get("/2.0/", {:query => {:method => 'track.search', :track => track, :page => page, :limit => limit, :api_key => Firstfm::CONFIG['api_key']}})
      tracks_array = (response and response["lfm"] and response["lfm"]["results"] and response["lfm"]["results"]["trackmatches"] and response["lfm"]["results"]["trackmatches"]["track"]) || []
      tracks = Track.init_from_array(tracks_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace tracks
        pager.total_entries = response['lfm']['results']['totalResults'].to_i
      end
    end
    
    def self.init_from_array(array)
      return [] unless array.is_a?(Array)
      array.inject([]) do |arr, track|
        arr << init_from_hash(track)
        arr
      end
    end
    
    def self.init_from_hash(hash)
      return nil unless hash.is_a?(Hash)
      Track.new.tap do |track|
        track.rank = hash["rank"].to_i
        track.name = hash["name"]
        track.mbid = hash["mbid"]
        track.url = hash["url"]
        track.listeners = hash["listeners"].to_i
        track.streamable = hash["streamable"] == "1"
        track.images = hash["image"]
        track.artist = hash["artist"].is_a?(Hash) ? Artist.init_from_hash(hash["artist"]) : Artist.new(:name => hash["artist"])
      end
    end
    
  end
  
end