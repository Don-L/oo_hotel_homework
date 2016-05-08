require_relative('../out_check_request.rb')
require('minitest/autorun')
require('minitest/rg')

class TestCheckOutRequest < Minitest::Test

  def setup
    @check_out_request = CheckOutRequest.new('Mr Brown', 90)
  end

  def test_check_out_request_name
    assert_equal('Mr Brown', @check_out_request.guest_name)
  end

  def test_check_out_request_amount_owed
    assert_equal(90, @check_out_request.amount_owed)
  end

end