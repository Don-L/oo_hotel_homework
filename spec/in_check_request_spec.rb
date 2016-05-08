require_relative('../in_check_request.rb')
require('minitest/autorun')
require('minitest/rg')

class TestCheckInRequest < Minitest::Test

  def setup
    @checkinrequest = CheckInRequest.new('Mr Brown', 2)
  end

  def test_name_of_guest_making_request
    assert_equal('Mr Brown', @checkinrequest.guest_name)
  end

  def test_number_of_rooms_requested
    assert_equal(2, @checkinrequest.number_of_rooms)
  end

end