class Hotel

  attr_reader(:name, :number_of_rooms, :room_price)

  def initialize(name, number_of_rooms, room_price)
    @name = name
    @number_of_rooms = number_of_rooms
    @room_price = room_price
  end

  def change_room_price(new_price)
    @room_price = new_price
  end

end