require_relative('../room.rb')
require('minitest/autorun')
require('minitest/rg')

class TestRoom < Minitest::Test

  def setup
    @room = Room.new(5, 20)
  end

  def test_room_has_a_number
    assert_equal(5, @room.room_number)
  end

  def test_room_has_a_price
    assert_equal(20, @room.price)
  end

  def test_new_room_is_unoccupied
    assert_equal(false, @room.is_occupied)
  end

  def test_can_change_occupancy_status
    @room.change_room_occupancy_status
    assert_equal(true, @room.is_occupied)
  end

  def test_can_change_occupancy_status_twice
    @room.change_room_occupancy_status
    @room.change_room_occupancy_status
    assert_equal(false, @room.is_occupied)
  end

  def test_can_change_price
    @room.change_price(90)
    assert_equal(90, @room.price)
  end








end