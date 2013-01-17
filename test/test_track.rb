require 'helper'
 
class TestTrack < Test::Unit::TestCase
  
  def test_should_search_tracks
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/tracks.xml"))
    tracks = Firstfm::Track.search("Believe")
    assert_equal 30, tracks.size
    assert_equal 1880, tracks.total_pages
    assert_equal 1, tracks.current_page
    assert_equal 56384, tracks.total_entries
    track = tracks.first
    #raise track.inspect
    assert_equal "Believe Me Natalie", track.name
    assert_equal 494607, track.listeners
    assert_equal "http://www.last.fm/music/The+Killers/_/Believe+Me+Natalie", track.url
    assert_equal nil, track.mbid
    assert track.streamable
    assert_equal 4, track.images.size
    assert_equal "The Killers", track.artist.name
  end
  
end