module Firstfm

  class Artist

    attr_accessor :name, :mbid, :url, :listeners, :streamable, :images, :playcount

    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :json

    def initialize(params = {})
      @name = params[:name]
    end

    def get_tags
      name_params = self.mbid.nil? ? {:artist => self.name} : {:mbid => self.mbid}
      response = self.class.get("/2.0/", {:query => {:method => 'artist.getInfo', :api_key => Firstfm.config.api_key, :format => :json}.merge(name_params)})
      tags_array = (response and response["artist"] and response["artist"]["tags"] and response["artist"]["tags"]["tag"]) || []
      tags_array.is_a?(Array) ? tags_array.map {|t| t["name"] } : []
    end

    def self.get_tags(artist)
      self.new(name: artist).get_tags
    end

    def self.search(artist, page = 1, limit = 50)
      response = get("/2.0/", {:query => {:method => 'artist.search', :artist => artist, :page => page, :limit => limit, :api_key => Firstfm.config.api_key, :format => :json}})
      artists_array = (response and response["results"] and response["results"]["artistmatches"] and response["results"]["artistmatches"]["artist"]) || []
      artists = Artist.init_from_array(artists_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace artists
        pager.total_entries = response['results']['opensearch:totalResults'].to_i rescue 0
      end
    end

    def self.get_top_tracks(artist, page = 1, limit = 50)
      response = get("/2.0/", {:query => {:method => 'artist.getTopTracks', :artist => artist, :page => page, :limit => limit, :api_key => Firstfm.config.api_key, :format => :json}})
      tracks_array = (response and response and response["toptracks"] and response["toptracks"]["track"]) || []
      tracks = Track.init_from_array(tracks_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace tracks
        pager.total_entries = response["toptracks"]["@attr"]["total"].to_i rescue 0
      end
    end

    def self.get_correction(artist)
      response = get("/2.0/", {:query => {:method => 'artist.getcorrection', :artist => artist, :api_key => Firstfm.config.api_key, :format => :json}})
      if response["corrections"] && response["corrections"]["correction"]
        init_from_hash(response["corrections"]["correction"]["artist"]) rescue nil
      elsif response.key?("corrections")
        init_from_hash({"name" => artist})
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
        artist.playcount = hash["playcount"].to_i
      end
    end

  end

end