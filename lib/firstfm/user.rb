module Firstfm

  class User

    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :json

    def self.get_top_artists(user, period = "overall", page = 1, limit = 50)
      response = get("/2.0/", {query: {method: 'user.getTopArtists', user: user, period: period, page: page, limit: limit, api_key: Firstfm.config.api_key, :format => :json}})
      artists_array = (response and response["topartists"] and response["topartists"]["artist"]) || []
      artists = Artist.init_from_array(artists_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace artists
        pager.total_entries = response['topartists']['@attr']['total'].to_i rescue 0
      end
    end

  end

end