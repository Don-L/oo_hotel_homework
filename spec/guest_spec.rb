require_relative('../guest.rb')
require('minitest/autorun')
require('minitest/rg')

class TestGuest < Minitest::Test

  def setup
    @guest = Guest.new('Mr Brown')
  end

  def test_new_guest_has_a_name
    assert_equal('Mr Brown', @guest.name)
  end

  def test_new_guest_occupies_0_rooms
    assert_equal(0, @guest.guest_rooms)
  end

  def test_new_guest_has_stayed_for_0_nights
    assert_equal(0, @guest.guest_nights)
  end

  def test_new_guest_owes_0
    assert_equal(0, @guest.amount_owed)
  end

  def test_can_change_guest_resident_status
    @guest.change_resident_status
    assert_equal(true, @guest.is_resident)
  end

  def test_can_change_guest_rooms
    @guest.change_guest_rooms(2)
    assert_equal(2, @guest.guest_rooms)
  end

  def test_can_change_guest_nights
    @guest.change_guest_nights(3)
    assert_equal(3,@guest.guest_nights)
  end
  
  def test_can_change_amount_owed
    @guest.update_amount_owed(100)
    assert_equal(100, @guest.amount_owed)
  end

end