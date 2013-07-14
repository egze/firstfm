require 'helper'
 
class TestUser < Test::Unit::TestCase
  
  def test_should_get_top_artists
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/user_artists.xml"))
    artists = Firstfm::User.get_top_artists("RJ")
    assert_equal 2, artists.size
    assert_equal 5702, artists.total_entries
    artist = artists.first
    assert_equal "Dream Theater", artist.name
    assert_equal 1797, artist.playcount
    assert_equal "http://www.last.fm/music/Dream+Theater", artist.url
    assert_equal "28503ab7-8bf2-4666-a7bd-2644bfc7cb1d", artist.mbid
    assert artist.streamable
    assert_equal 5, artist.images.size
  end
  
end