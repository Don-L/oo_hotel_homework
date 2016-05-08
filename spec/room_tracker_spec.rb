require_relative('../room_tracker.rb')
require('minitest/autorun')
require('minitest/rg')

class TestRoomTracker < Minitest::Test

  def setup
    @roomtracker = RoomTracker.new(4)
  end

  def test_room_tracker_shows_4_rooms
    assert_equal(4, @roomtracker.number_of_rooms)
  end

  def test_room_tracker_list_is_array_of_correct_length
    assert_equal(4, @roomtracker.list_of_rooms_and_guests.length)
  end

  def test_initial_room_tracker_list_contains_0s
    assert_equal([0,0,0,0], @roomtracker.list_of_rooms_and_guests)
  end

  def test_can_add_occupied_rooms_to_list
    @roomtracker.assign_room_to_guest('Mr Brown', 2)
    assert_equal('Mr Brown', @roomtracker.list_of_rooms_and_guests[0])
  end

  def test_can_add_further_occupied_rooms
    @roomtracker.assign_room_to_guest('Mr Brown', 2)
    @roomtracker.assign_room_to_guest('Mr Green', 1)
    assert_equal('Mr Green', @roomtracker.list_of_rooms_and_guests[2])
  end

  def test_can_remove_occupants_from_rooms
    @roomtracker.assign_room_to_guest('Mr Brown', 2)
    @roomtracker.assign_room_to_guest('Mr Green', 1)
    @roomtracker.remove_occupant('Mr Brown')
    assert_equal([0,0,"Mr Green", 0], @roomtracker.list_of_rooms_and_guests)
  end

  def test_can_obtain_number_of_available_rooms
    @roomtracker.assign_room_to_guest('Mr Brown', 2)
    @roomtracker.assign_room_to_guest('Mr Green', 1)
    assert_equal(1, @roomtracker.rooms_available)
  end

end