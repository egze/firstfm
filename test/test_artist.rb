require 'helper'

class TestArtist < Test::Unit::TestCase

  def test_should_search_artists
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/artists.json"))
    artists = Firstfm::Artist.search("Cher")
    assert_equal 30, artists.size
    assert_equal 9, artists.total_pages
    assert_equal 1, artists.current_page
    assert_equal 424, artists.total_entries
    artist = artists.first
    assert_equal "Cheryl Cole", artist.name
    assert_equal 627821, artist.listeners
    assert_equal "http://www.last.fm/music/Cheryl+Cole", artist.url
    assert_equal "2d499150-1c42-4ffb-a90c-1cc635519d33", artist.mbid
    assert !artist.streamable
    assert_equal 5, artist.images.size
  end

  def test_should_get_top_tracks
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/top_tracks.json"))
    tracks = Firstfm::Artist.get_top_tracks("Cher")
    assert_equal 50, tracks.size
    assert_equal 509, tracks.total_pages
    assert_equal 1, tracks.current_page
    assert_equal 25441, tracks.total_entries
    track = tracks.first
    assert_equal "Believe", track.name
    assert_equal 371216, track.listeners
    assert_equal "http://www.last.fm/music/Cher/_/Believe", track.url
    assert_equal "32ca187e-ee25-4f18-b7d0-3b6713f24635", track.mbid
    assert !track.streamable
    assert_equal 4, track.images.size
    assert_equal 1, track.rank
    assert_equal "Cher", track.artist.name
  end

  def test_should_get_tags
    artist = Firstfm::Artist.new :name => "Cher"

    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/artist.json"))
    tags = artist.get_tags
    assert_equal 5, tags.size
    assert (tags - ["pop", "female vocalists", "80s", "dance", "rock"]).empty?
  end

  def test_should_get_correction
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/get_correction.json"))
    artist = Firstfm::Artist.get_correction("Guns")
    assert_equal "Guns N' Roses", artist.name
    assert_equal "eeb1195b-f213-4ce1-b28c-8565211f8e43", artist.mbid
    assert_equal "http://www.last.fm/music/Guns+N%27+Roses", artist.url
  end

  def test_should_get_correction_even_if_correct
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/get_correction_blank.json"))
    artist = Firstfm::Artist.get_correction("Eminem")
    assert_equal "Eminem", artist.name
  end

end