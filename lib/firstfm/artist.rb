module Firstfm
  
  class Artist
    
    attr_accessor :name, :mbid, :url, :listeners, :streamable, :images
   
    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :xml
    
    def initialize(params = {})
      @name = params[:name]
    end
    
    def self.search(artist, page = 1, limit = 50)
      response = get("/2.0/", {:query => {:method => 'artist.search', :artist => artist, :page => page, :limit => limit, :api_key => Firstfm::CONFIG['api_key']}})
      artists_array = (response and response["lfm"] and response["lfm"]["results"] and response["lfm"]["results"]["artistmatches"] and response["lfm"]["results"]["artistmatches"]["artist"]) || []
      artists = Artist.init_from_array(artists_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace artists
        pager.total_entries = response['lfm']['results']['opensearch:totalResults'].to_i
      end
    end
    
    def self.get_top_tracks(artist, page = 1, limit = 50)
      response = get("/2.0/", {:query => {:method => 'artist.getTopTracks', :artist => artist, :page => page, :limit => limit, :api_key => Firstfm::CONFIG['api_key']}})
      tracks_array = (response and response["lfm"] and response["lfm"]["toptracks"] and response["lfm"]["toptracks"]["track"]) || []
      tracks = Track.init_from_array(tracks_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace tracks
        pager.total_entries = response["lfm"]["toptracks"]["total"].to_i
      end
    end
    
    def self.init_from_array(array)
      return [] unless array.is_a?(Array)
      array.inject([]) do |arr, artist|
        arr << init_from_hash(artist)
        arr
      end
    end
    
    def self.init_from_hash(hash)
      return nil unless hash.is_a?(Hash)
      Artist.new.tap do |artist|
        artist.name = hash["name"]
        artist.mbid = hash["mbid"]
        artist.url = hash["url"]
        artist.listeners = hash["listeners"].to_i
        artist.streamable = hash["streamable"] == "1"
        artist.images = hash["image"]
      end
    end
    
  end
  
end