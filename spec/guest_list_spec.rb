require_relative('../guest_list.rb')
require_relative('../guest')
require('minitest/autorun')
require('minitest/rg')

class TestGuestList < Minitest::Test

  def setup
    @guest1 = Guest.new('Mr Brown')
    @guest2 = Guest.new('Mr Green')
    @guest_list = GuestList.new
  end


  def test_can_add_guest_to_list
    @guest_list.add_guest(@guest2)
    assert_equal('Mr Green', @guest_list.list[0].name)
  end

  def test_can_remove_guest_from_list
    @guest_list.add_guest(@guest1)
    @guest_list.add_guest(@guest2)
    @guest_list.remove_guest(@guest1)
    assert_equal(1, @guest_list.list.length)
  end












end