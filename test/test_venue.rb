require 'helper'
 
class TestVenue < Test::Unit::TestCase
  
  def test_should_search_venues
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/venues.xml"))
    venues = Firstfm::Venue.search("arena")
    assert_equal 2, venues.size
    venue = venues.first
    assert_equal "Arena", venue.name
    assert_equal "Baumgasse 80", venue.location.street
    venue = venues.last
    assert_equal "8781374", venue.id
    assert_equal "41.056222", venue.location.lat
  end
  
  def test_should_search_venues_with_one_venue_as_result
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/venue.xml"))
    venues = Firstfm::Venue.search("arena")
    assert_equal 1, venues.size
    venue = venues.first
    assert_equal "Arena", venue.name
    assert_equal "8778545", venue.id
    assert_equal "Baumgasse 80", venue.location.street
  end
  
  def test_should_get_events
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/events.xml"))
    events = Firstfm::Venue.get_events(8908030)
    assert_equal 2, events.size
    
    event = events.first
    assert_equal "U.S. Girls", event.title
    assert_equal "1313175", event.id
    assert_equal "Cafe OTO", event.venue.name
    
    event = events.last
    assert_equal "Shogun Kunitoki", event.title
    assert_equal "1372916", event.id
    assert_equal "Cafe OTO", event.venue.name
  end
  
  def test_should_get_events_with_one_event_as_result
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/event.xml"))
    events = Firstfm::Venue.get_events(8908030)
    assert_equal 1, events.size
    
    event = events.first
    assert_equal "U.S. Girls", event.title
    assert_equal "1313175", event.id
    assert_equal "Cafe OTO", event.venue.name
  end
  
  def test_should_get_events_from_single_venue
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/venue.xml"))
    venues = Firstfm::Venue.search("arena")
    venue = venues.first
    venue.id = 8908030
    
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/event.xml"))
    
    events = venue.get_events
    assert_equal 1, events.size
    
    event = events.first
    assert_equal "U.S. Girls", event.title
    assert_equal "1313175", event.id
    assert_equal "Cafe OTO", event.venue.name
  end
  
end