class Guest

  attr_accessor(:name, :guest_rooms, :guest_nights, :amount_owed, :is_resident)

  def initialize(name, guest_rooms)
    @name = name
    @guest_rooms = guest_rooms
    @guest_nights = 0
    @amount_owed = 0
    @is_resident = false
  end

  def change_guest_rooms(number_of_rooms)
    @guest_rooms = number_of_rooms
  end

  def change_guest_nights(number_of_nights)
    @guest_nights = number_of_nights
  end

  def update_amount_owed(new_amount)
    @amount_owed = new_amount
  end

  def change_resident_status
    if @is_resident == false
      @is_resident = true
    else @is_resident = false
    end
  end

end