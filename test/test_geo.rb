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
  
end