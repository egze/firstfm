# encoding: utf-8

require 'helper'
 
class TestGeo < Test::Unit::TestCase
  
  def test_should_get_events
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_events.xml"))
    events = Firstfm::Geo.get_events
    assert_equal 2, events.size
    
    event = events.first
    assert_equal "Entre Coche", event.title
    assert_equal "1405068", event.id
    assert_equal "La Boite", event.venue.name
    
    event = events.last
    assert_equal "Bonafide", event.title
    assert_equal "1443807", event.id
    assert_equal "Ritmo y Compás", event.venue.name
  end
  
  def test_should_get_events_with_one_event_as_result
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_event.xml"))
    events = Firstfm::Geo.get_events
    assert_equal 1, events.size
    
    event = events.first
    assert_equal "Entre Coche", event.title
    assert_equal "1405068", event.id
    assert_equal "La Boite", event.venue.name
  end
  
  def test_should_get_metro_artist_chart
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.xml"))
    artists = Firstfm::Geo.get_metro_artist_chart
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last
    
    assert_equal "Coldplay", artist1.name
    assert_equal "cc197bad-dc9c-440d-a5b5-d52ba2e14234", artist1.mbid
    assert_equal "http://www.last.fm/music/Coldplay", artist1.url
    assert_equal 558, artist1.listeners
    assert artist1.streamable
    
    assert_equal "Adele", artist2.name
    assert_equal "1de93a63-3a9f-443a-ba8a-a43b5fe0121e", artist2.mbid
    assert_equal "http://www.last.fm/music/Adele", artist2.url
    assert_equal 552, artist2.listeners
    assert artist2.streamable
  end
  
  def test_should_get_metro_hype_artist_chart
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.xml"))
    artists = Firstfm::Geo.get_metro_hype_artist_chart
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last
    
    assert_equal "Coldplay", artist1.name
    assert_equal "cc197bad-dc9c-440d-a5b5-d52ba2e14234", artist1.mbid
    assert_equal "http://www.last.fm/music/Coldplay", artist1.url
    assert_equal 558, artist1.listeners
    assert artist1.streamable
    
    assert_equal "Adele", artist2.name
    assert_equal "1de93a63-3a9f-443a-ba8a-a43b5fe0121e", artist2.mbid
    assert_equal "http://www.last.fm/music/Adele", artist2.url
    assert_equal 552, artist2.listeners
    assert artist2.streamable
  end
  
  def test_should_get_metro_unique_artist_chart
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.xml"))
    artists = Firstfm::Geo.get_metro_unique_artist_chart
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last
    
    assert_equal "Coldplay", artist1.name
    assert_equal "cc197bad-dc9c-440d-a5b5-d52ba2e14234", artist1.mbid
    assert_equal "http://www.last.fm/music/Coldplay", artist1.url
    assert_equal 558, artist1.listeners
    assert artist1.streamable
    
    assert_equal "Adele", artist2.name
    assert_equal "1de93a63-3a9f-443a-ba8a-a43b5fe0121e", artist2.mbid
    assert_equal "http://www.last.fm/music/Adele", artist2.url
    assert_equal 552, artist2.listeners
    assert artist2.streamable
  end
  
  def test_should_get_top_artists
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/geo_get_metro_artist_chart.xml"))
    artists = Firstfm::Geo.get_top_artists
    assert_equal 2, artists.size
    artist1 = artists.first
    artist2 = artists.last
    
    assert_equal "Coldplay", artist1.name
    assert_equal "cc197bad-dc9c-440d-a5b5-d52ba2e14234", artist1.mbid
    assert_equal "http://www.last.fm/music/Coldplay", artist1.url
    assert_equal 558, artist1.listeners
    assert artist1.streamable
    
    assert_equal "Adele", artist2.name
    assert_equal "1de93a63-3a9f-443a-ba8a-a43b5fe0121e", artist2.mbid
    assert_equal "http://www.last.fm/music/Adele", artist2.url
    assert_equal 552, artist2.listeners
    assert artist2.streamable
  end
  
end