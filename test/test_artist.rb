require 'helper'
 
class TestArtist < Test::Unit::TestCase
  
  def test_should_search_artists
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/artists.xml"))
    artists = Firstfm::Artist.search("Cher")
    assert_equal 30, artists.size
    assert_equal 9, artists.total_pages
    assert_equal 1, artists.current_page
    assert_equal 424, artists.total_entries
    artist = artists.first
    assert_equal "Cher", artist.name
    assert_equal 666642, artist.listeners
    assert_equal "http://www.last.fm/music/Cher", artist.url
    assert_equal "bfcc6d75-a6a5-4bc6-8282-47aec8531818", artist.mbid
    assert artist.streamable
    assert_equal 5, artist.images.size
  end
  
  def test_should_get_top_tracks
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/top_tracks.xml"))
    tracks = Firstfm::Artist.get_top_tracks("Cher")
    assert_equal 50, tracks.size
    assert_equal 20, tracks.total_pages
    assert_equal 1, tracks.current_page
    assert_equal 1000, tracks.total_entries
    track = tracks.first
    assert_equal "Believe", track.name
    assert_equal 35805, track.listeners
    assert_equal "http://www.last.fm/music/Cher/_/Believe", track.url
    assert_equal nil, track.mbid
    assert track.streamable
    assert_equal 4, track.images.size
    assert_equal 1, track.rank
    assert_equal "Cher", track.artist.name
  end
  
  def test_should_get_images
    artist = Firstfm::Artist.new :name => "Cher"
    
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/get_images.xml"))
    images = artist.get_images
    assert_equal 50, images.size
    assert images.detect {|i| i.with_width(600) }
  end

  def test_should_get_tags
    artist = Firstfm::Artist.new :name => "Cher"
    
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/artist.xml"))
    tags = artist.get_tags
    assert_equal 5, tags.size
    assert (tags - ["pop", "female vocalists", "80s", "dance", "rock"]).empty?
  end
  
  def test_should_get_correction
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/get_correction.xml"))
    artist = Firstfm::Artist.get_correction("Guns")
    assert_equal "Guns N' Roses", artist.name
    assert_equal "6e40312c-2a6d-445b-b2c9-f68e86f6a0a3", artist.mbid
    assert_equal "http://www.last.fm/music/Guns+N%27+Roses", artist.url
  end
  
  def test_should_get_correction_even_if_correct
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/get_correction_blank.xml"))
    artist = Firstfm::Artist.get_correction("Eminem")
    assert_equal "Eminem", artist.name
  end
  
end