module Firstfm
  
  class User
    
    include HTTParty
    base_uri 'ws.audioscrobbler.com'
    format :xml
    
    def self.get_top_artists(user, period = "overall", page = 1, limit = 50)
      response = get("/2.0/", {query: {method: 'user.getTopArtists', user: user, period: period, page: page, limit: limit, api_key: Firstfm.config.api_key}})
      artists_array = (response and response["lfm"] and response["lfm"]["topartists"] and response["lfm"]["topartists"]["artist"]) || []
      artists = Artist.init_from_array(artists_array)
      WillPaginate::Collection.create(page, limit) do |pager|
        pager.replace artists
        pager.total_entries = response['lfm']['topartists']['total'].to_i rescue 0
      end
    end
    
  end
  
end