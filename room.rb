require('pry-byebug')

class Room

  attr_accessor(:room_number, :price, :is_occupied)
#you can't use a question mark in the name of an instance variable
  def initialize(room_number, price)
    @room_number = room_number
    @price = price
    @is_occupied = false
  end

  def change_room_occupancy_status
    if @is_occupied == false
      @is_occupied = true
    else @is_occupied = false
    end
  end

  def change_price(new_price)
    @price = new_price
  end

end

