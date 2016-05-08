require_relative('manager_prompt.rb')
require_relative('guest')
require_relative('guest_list.rb')
require_relative('hotel.rb')
require_relative('room_tracker')
require_relative('manager')

manager = Manager.new
hotel = Hotel.new('My Hotel', 12, 50)
room_tracker = RoomTracker.new(12)
guest_list = GuestList.new


manager.main_menu(hotel, room_tracker, guest_list)