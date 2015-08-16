module Firstfm

  class Track

    attr_accessor :name, :artist, :url, :streamable, :listeners, :images, :mbid, :rank

    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :json

    def self.search(track, page = 1, limit = 30)
      response = get("/2.0/", {:query => {:method => 'track.search', :track => track, :page => page, :limit => limit, :api_key => Firstfm.config.api_key, :format => :json}})
      tracks_array = (response and response["results"] and response["results"]["trackmatches"] and response["results"]["trackmatches"]["track"]) || []
      tracks = Track.init_from_array(tracks_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace tracks
        pager.total_entries = response['results']['opensearch:totalResults'].to_i
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
        track.rank = hash["@attr"]["rank"].to_i if hash["@attr"]
        track.name = hash["name"]
        track.mbid = hash["mbid"].to_s.size > 0 ? hash["mbid"] : nil
        track.url = hash["url"]
        track.listeners = hash["listeners"].to_i
        track.streamable = false
        track.images = hash["image"]
        track.artist = hash["artist"].is_a?(Hash) ? Artist.init_from_hash(hash["artist"]) : Artist.new(:name => hash["artist"])
      end
    end

  end

end