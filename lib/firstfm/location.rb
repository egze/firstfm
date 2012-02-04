module Firstfm
  
  class Location
    
    attr_accessor :city, :country, :postalcode, :lat, :long, :street
    
    def self.init_location_from_hash(hash)
      return nil unless hash.is_a?(Hash)
      
      location = Location.new
      location.city         = hash["city"]
      location.country      = hash["country"]
      location.postalcode   = hash["postalcode"]
      location.street       = hash["street"]
      location.lat          = hash["point"]["lat"] if hash["point"]
      location.long         = hash["point"]["long"] if hash["point"]
      location
    end
    
  end
  
end