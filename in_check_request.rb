class CheckInRequest

  attr_reader(:guest_name, :number_of_rooms)

  def initialize(guest_name, number_of_rooms)
    @guest_name = guest_name
    @number_of_rooms = number_of_rooms
  end

end