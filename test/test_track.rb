require 'helper'

class TestTrack < Test::Unit::TestCase

  def test_should_search_tracks
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/tracks.json"))
    tracks = Firstfm::Track.search("Believe")
    assert_equal 30, tracks.size
    assert_equal 888, tracks.total_pages
    assert_equal 1, tracks.current_page
    assert_equal 26620, tracks.total_entries
    track = tracks.first
    #raise track.inspect
    assert_equal "Believe", track.name
    assert_equal 248, track.listeners
    assert_equal "http://www.last.fm/music/BELIEVE/_/Believe", track.url
    assert_equal nil, track.mbid
    assert_equal 4, track.images.size
    assert_equal "BELIEVE", track.artist.name
  end

end