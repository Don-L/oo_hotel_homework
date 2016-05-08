require_relative('guest')

class RoomTracker

  attr_accessor(:number_of_rooms, :list_of_rooms_and_guests)

  def initialize(number_of_rooms)
    @number_of_rooms = number_of_rooms
    list = []
    number_of_rooms.times do |i|
      list.push(0)
    end
    @list_of_rooms_and_guests = list
  end

  def assign_room_to_guest(guest_name, number_of_rooms_to_assign)
    number_of_rooms_to_assign.times do |i|
      @list_of_rooms_and_guests[@list_of_rooms_and_guests.index(0)] = guest_name
    end
  end

  def remove_occupant(guest_name)
      @list_of_rooms_and_guests.map! do |a|
        if a == guest_name
          a = 0
        else a = a
        end
      end
  end

  def rooms_available
    n = 0
    for room in @list_of_rooms_and_guests
      if room == 0
        n += 1
      end
    end
    return n
  end

  def display_room_tracker
    puts ' '
    puts "ROOM NUMBER".ljust(15) + "--" + "REGISTERED GUEST".rjust(20)
    i = 1
    for entry in @list_of_rooms_and_guests
      puts "#{@list_of_rooms_and_guests.length - @list_of_rooms_and_guests.length + i}".ljust(15) + "--" + "#{entry}".rjust(20)
      i += 1
    end
    puts ' '
  end

end




