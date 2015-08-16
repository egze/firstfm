module Firstfm

  class Geo

    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :json

    def self.get_events(params = {})
      location = params.delete(:location)
      lat = params.delete(:lat)
      lng = params.delete(:lng)
      page = params.delete(:page) || 1
      distance = params.delete(:distance)

      response = get("/2.0/", {:query => {:method => 'geo.getevents', :location => location, :page => page, :lat => lat, :lng => lng, :distance => distance, :api_key => Firstfm.config.api_key, :format => :json}})
      events = response ? Event.init_events_from_hash(response) : []
      collection = WillPaginate::Collection.create(page, 10) do |pager|
        pager.replace events
        pager.total_entries = response['events']['@attr']['total'].to_i
      end

    end

    def self.get_top_artists(params = {})
      country = params[:country]
      page = params[:page] || 1
      limit = params[:limit] || 50

      response = get("/2.0/", {:query => {
        :method => 'geo.gettopartists',
        :country => country,
        :page => page,
        :limit => limit,
        :api_key => Firstfm.config.api_key, :format => :json
      }})

      artists_array = (response and response['topartists'] and response['topartists']['artist']) || []
      artists = Artist.init_from_array(artists_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace artists
        pager.total_entries = response['topartists']['@attr']['total'].to_i rescue 0
      end
    end

    def self.get_metro_artist_chart(params = {})
      get_generic_artist_chart 'geo.getmetroartistchart', params
    end

    def self.get_metro_hype_artist_chart(params = {})
      get_generic_artist_chart 'geo.getmetrohypeartistchart', params
    end

    def self.get_metro_unique_artist_chart(params = {})
      get_generic_artist_chart 'geo.getmetrouniqueartistchart', params
    end

    def self.get_generic_artist_chart(method, params = {})
      metro = params[:metro]
      country = params[:country]
      start_timestamp = params[:start]
      end_timestamp = params[:end]
      page = params[:page] || 1
      limit = params[:limit] || 50

      response = get("/2.0/", {:query => {
        :method => method,
        :country => country,
        :metro => metro,
        :start => start_timestamp,
        :end => end_timestamp,
        :page => page,
        :limit => limit,
        :api_key => Firstfm.config.api_key, :format => :json }.reject {|k,v| v.nil?}
      })

      artists_array = (response and response['topartists'] and response['topartists']['artist']) || []
      artists = Artist.init_from_array(artists_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace artists
        pager.total_entries = response['topartists']['@attr']['total'].to_i rescue 0
      end
    end

  end

end