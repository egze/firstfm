# encoding: utf-8

require 'helper'

class TestGeo < Test::Unit::TestCase

  def test_should_get_events
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_events.json"))
    events = Firstfm::Geo.get_events
    assert_equal 10, events.size

    event = events.first
    assert_equal "Fiestas de La Paloma", event.title
    assert_equal "4174420", event.id
    assert_equal "Fiestas de La Paloma - Plaza de las Vistillas", event.venue.name

    event = events.last
    assert_equal "XIV LechuRock", event.title
    assert_equal "4161678", event.id
    assert_equal "Plaza de toros", event.venue.name
  end

  def test_should_get_events_with_one_event_as_result
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_event.json"))
    events = Firstfm::Geo.get_events
    assert_equal 1, events.size

    event = events.first
    assert_equal "Fiestas de La Paloma", event.title
    assert_equal "4174420", event.id
    assert_equal "Fiestas de La Paloma - Plaza de las Vistillas", event.venue.name
  end

  def test_should_get_metro_artist_chart
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.json"))
    artists = Firstfm::Geo.get_metro_artist_chart
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last

    assert_equal "Muse", artist1.name
    assert_equal "1695c115-bf3f-4014-9966-2b0c50179193", artist1.mbid
    assert_equal "http://www.last.fm/music/Muse", artist1.url
    assert_equal 359, artist1.listeners
    assert !artist1.streamable

    assert_equal "Major Lazer", artist2.name
    assert_equal "75be165a-ad83-4d12-bd28-f589a15c479f", artist2.mbid
    assert_equal "http://www.last.fm/music/Major+Lazer", artist2.url
    assert_equal 310, artist2.listeners
    assert !artist2.streamable
  end

  def test_should_get_metro_hype_artist_chart
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.json"))
    artists = Firstfm::Geo.get_metro_hype_artist_chart
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last

    assert_equal "Muse", artist1.name
    assert_equal "1695c115-bf3f-4014-9966-2b0c50179193", artist1.mbid
    assert_equal "http://www.last.fm/music/Muse", artist1.url
    assert_equal 359, artist1.listeners
    assert !artist1.streamable

    assert_equal "Major Lazer", artist2.name
    assert_equal "75be165a-ad83-4d12-bd28-f589a15c479f", artist2.mbid
    assert_equal "http://www.last.fm/music/Major+Lazer", artist2.url
    assert_equal 310, artist2.listeners
    assert !artist2.streamable
  end

  def test_should_get_metro_unique_artist_chart
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.json"))
    artists = Firstfm::Geo.get_metro_unique_artist_chart
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last

    assert_equal "Muse", artist1.name
    assert_equal "1695c115-bf3f-4014-9966-2b0c50179193", artist1.mbid
    assert_equal "http://www.last.fm/music/Muse", artist1.url
    assert_equal 359, artist1.listeners
    assert !artist1.streamable

    assert_equal "Major Lazer", artist2.name
    assert_equal "75be165a-ad83-4d12-bd28-f589a15c479f", artist2.mbid
    assert_equal "http://www.last.fm/music/Major+Lazer", artist2.url
    assert_equal 310, artist2.listeners
    assert !artist2.streamable
  end

  def test_should_get_top_artists
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.json"))
    artists = Firstfm::Geo.get_top_artists
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last

    assert_equal "Muse", artist1.name
    assert_equal "1695c115-bf3f-4014-9966-2b0c50179193", artist1.mbid
    assert_equal "http://www.last.fm/music/Muse", artist1.url
    assert_equal 359, artist1.listeners
    assert !artist1.streamable

    assert_equal "Major Lazer", artist2.name
    assert_equal "75be165a-ad83-4d12-bd28-f589a15c479f", artist2.mbid
    assert_equal "http://www.last.fm/music/Major+Lazer", artist2.url
    assert_equal 310, artist2.listeners
    assert !artist2.streamable
  end

end