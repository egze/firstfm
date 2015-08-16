require 'helper'

class TestVenue < Test::Unit::TestCase

  def test_should_search_venues
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/venues.json"))
    venues = Firstfm::Venue.search("arena")
    assert_equal 2, venues.size
    venue = venues.first
    assert_equal "Arena", venue.name
    assert_equal "Baumgasse 80", venue.location.street
    venue = venues.last
    assert_equal "10319137", venue.id
    assert_equal "-23.515061", venue.location.lat
  end

  def test_should_get_events
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/events.json"))
    events = Firstfm::Venue.get_events(8908030)
    assert_equal 2, events.size

    event = events.first
    assert_equal "Sun Ra Arkestra", event.title
    assert_equal "4167492", event.id
    assert_equal "Cafe OTO", event.venue.name

    event = events.last
    assert_equal "Alessandro Cortini", event.title
    assert_equal "4175250", event.id
    assert_equal "Cafe OTO", event.venue.name
  end

  def test_should_get_events_from_single_venue
    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/venues.json"))
    venues = Firstfm::Venue.search("arena")
    venue = venues.first
    venue.id = 8908030

    FakeWeb.register_uri(:get, %r|http://ws.audioscrobbler.com/|, :body => File.read(File.dirname(__FILE__) + "/fixtures/events.json"))

    events = venue.get_events
    assert_equal 2, events.size

    event = events.first
    assert_equal "Sun Ra Arkestra", event.title
    assert_equal "4167492", event.id
    assert_equal "Cafe OTO", event.venue.name
  end

end