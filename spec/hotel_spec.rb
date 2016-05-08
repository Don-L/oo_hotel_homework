require_relative('../hotel.rb')
require('minitest/autorun')
require('minitest/rg')

class TestHotel < Minitest::Test

  def setup
    @hotel = Hotel.new('No Advance Booking Hotel', 12)
  end

  def test_hotel_has_name
    assert_equal('No Advance Booking Hotel', @hotel.name)
  end

  def test_hotel_contains_a_number_of_rooms
    assert_equal(12, @hotel.number_of_rooms)
  end

end