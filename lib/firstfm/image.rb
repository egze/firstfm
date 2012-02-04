module Firstfm
  
  class Image
    
    attr_accessor :title, :url, :dateadded, :format, :owner_name, :owner_url, :sizes, :thumbsup, :thumbsdown, :artist
        
    def self.init_from_array(array)
      return [] unless array.is_a?(Array)
      array.inject([]) do |arr, image|
        arr << init_from_hash(image)
        arr
      end
    end
    
    def self.init_from_hash(hash)
      return nil unless hash.is_a?(Hash)
      Image.new.tap do |image|
        image.title = hash["title"]
        image.url = hash["url"]
        image.dateadded = Chronic.parse(hash["dateadded"])
        image.format = hash["format"]
        image.sizes = hash["sizes"]["size"]
      end
    end
    
    def original
      self.sizes.detect {|s| s.attributes["name"] == "original"}
    end
    
    def with_width(width)
      self.sizes.detect {|s| s.attributes["width"].to_i >= width}
    end
    
  end
  
end