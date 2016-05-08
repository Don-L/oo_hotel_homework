require_relative('manager_prompt.rb')
require_relative('guest')
require_relative('guest_list.rb')
require_relative('hotel.rb')
require_relative('room_tracker')

class Manager

  def initialize
  end

  def print_prompt(manager_prompt)
    puts ' '
    puts manager_prompt.query
    puts ' '
    for option in manager_prompt.options_list
      puts"[#{option[0]}] > #{option[1]}"
    end
    puts ' '
    response = gets.chomp.to_i
    check_user_response(response, manager_prompt)
  end

  def check_user_response(response, prompt)
    option_numbers = []
    for option in prompt.options_list
      option_numbers << option[0]
    end
    if option_numbers.include?(response)
      return response
    else
        puts ' '
        puts 'Input not recognised. Please enter a number from the listed options.'
        puts ' '
        print_prompt(prompt)
    end
  end

  def end_day(hotel, room_tracker, guest_list)
    prompt = ManagerPrompt.new("Are you sure you want to end the day? There's no going back if you decide to do this!", [[1, "No, I don't want to end the day just yet - return to main menu;"], [2, "Yes, I'm sure; end the day."]])
    response = print_prompt(prompt)
    if response == 1
      main_menu(hotel, room_tracker, guest_list)
    elsif response == 2
      for guest in guest_list.list
        guest.guest_nights += 1
        guest.amount_owed +=  guest.guest_rooms * hotel.room_price
      end
      puts ' '
      puts "Day ended! Customer accounts updated. Returning to main menu."
      main_menu(hotel, room_tracker, guest_list)
    end
  end

  def main_menu(hotel, room_tracker, guest_list)
    opening_prompt = ManagerPrompt.new("MAIN MENU \n \nWhat would you like to do?", [[1, "View price of rooms;"], [2, "Change price of rooms;"],[3, "Check rooms available;"], [4, "View rooms and occupants;"], [5, "View guests / process check-out request;"], [6, "Process check-in request;"], [7, "End the day."]])
      user_input = print_prompt(opening_prompt) 
      if user_input == 1
        manager_view_room_price(hotel, room_tracker, guest_list)
      elsif user_input == 2
        manager_change_room_price(hotel, room_tracker, guest_list)
      elsif user_input == 3
        manager_check_rooms_available(hotel, room_tracker, guest_list)
      elsif user_input == 4
        manager_show_room_tracker(hotel, room_tracker, guest_list)
      elsif user_input == 5
        manager_view_guest_list(hotel, room_tracker, guest_list)
      elsif user_input == 6
        manager_process_check_in_request_name(hotel, guest_list, room_tracker)
      elsif user_input == 7
        end_day(hotel, room_tracker, guest_list)
      end
  end

  def manager_change_room_price(hotel, room_tracker, guest_list)
    puts ' '
    puts 'Please enter the new cost in £ of renting a room for one night. You will be asked to confirm the new cost before any change is made: '
    puts ' '
    new_price = gets.chomp.to_f.round(2)
    if new_price > 0
      puts ' '
      confirm_room_price_prompt = ManagerPrompt.new("You have specified that the cost of renting a room should be set to £#{new_price} per night. What would you like to do?", [[1, "Set £#{new_price} as the new cost of a room;"], [2, "Choose a different price"], [3, "Return to main menu"]])
      response = print_prompt(confirm_room_price_prompt)
      if response == 1
        hotel.change_room_price(new_price)
        puts ' '
        puts "Rooms at this hotel now cost £#{new_price} per night."
        main_menu(hotel, room_tracker, guest_list)
      elsif response == 2
        manager_change_room_price(hotel, room_tracker, guest_list)
      elsif response == 3
        main_menu(hotel, room_tracker, guest_list)
      end
    elsif new_price <= 0
      puts ' '
      puts "Sorry, you need to enter a number higher than zero to set a new price. Please note that you should not use the '£' sign when entering the price."
      manager_change_room_price(hotel, room_tracker, guest_list)
    end
  end

  def manager_view_room_price(hotel, room_tracker, guest_list)
    puts' '
    puts "The cost of renting a room for the night is currently £#{hotel.room_price}."
    main_menu(hotel, room_tracker, guest_list)
  end

  def manager_check_rooms_available(hotel, room_tracker, guest_list)
    puts ' '
    puts "The hotel currently has #{room_tracker.rooms_available} rooms available."
    main_menu(hotel, room_tracker, guest_list)
  end

  def manager_show_room_tracker(hotel, room_tracker, guest_list)
    room_tracker.display_room_tracker
    main_menu(hotel, room_tracker, guest_list)
  end

  def manager_view_guest_list(hotel, room_tracker, guest_list)
    if guest_list.list.length == 0
      puts ' '
      puts 'No guests are currently staying at the hotel'
      main_menu(hotel, room_tracker, guest_list)
    else
      display_guests(guest_list, hotel, room_tracker)
    end
  end

  def display_guests(guest_list, hotel, room_tracker)
    guests = []
    for guest in guest_list.list
      guests << [guest_list.list.index(guest) + 1, guest.name]
    end
    prompt = ManagerPrompt.new("Enter a number to view guest information or to process guest check-out request: ", guests)
    response = print_prompt(prompt)
    response -= 1
    manager_view_guest_details(response, guest_list, hotel, room_tracker)
  end

  def manager_view_guest_details(response, guest_list, hotel, room_tracker)
    puts ' '
    puts "Customer name:     #{guest_list.list[response].name}"
    puts "Number of rooms:   #{guest_list.list[response].guest_rooms}"
    puts "Number of nights:  #{guest_list.list[response].guest_nights}"
    puts "Amount owed:      £#{guest_list.list[response].amount_owed}"
    prompt = ManagerPrompt.new("What would you like to do?", [[0, 'Return to main menu;'], [1, 'View another guest;'], [2, 'Check-out guest.']])
    response2 = print_prompt(prompt)
    if response2 == 0
      main_menu(hotel, room_tracker, guest_list)
    elsif response2 == 1
      display_guests(guest_list, hotel, room_tracker)
    elsif response2 == 2
      puts ' '
      guest = guest_list.list[response]
      manager_process_check_out_request(guest, guest_list, hotel, room_tracker)
    end
  end

  def manager_process_check_out_request(guest, guest_list, hotel, room_tracker)
    prompt = ManagerPrompt.new("Settlement amount for #{guest.name} is £#{guest.amount_owed}. Confirm account settled and remove guest from records?", [[0, 'No - cancel check-out and return to main menu;'], [1, 'Yes - confirm account settled and check out guest.']])
      response = print_prompt(prompt)
      if response == 0
        main_menu(hotel, room_tracker, guest_list)
      elsif response == 1
        guest_list.remove_guest(guest)
        room_tracker.remove_occupant(guest.name)
        puts ' '
        puts "#{guest.name}'s account has been settled and they have been checked out."
        main_menu(hotel, room_tracker, guest_list)
      end
  end

  def manager_process_check_in_request_name(hotel, guest_list, room_tracker)
    if room_tracker.rooms_available == 0
      puts ' '
      puts 'There are no rooms available. Returning to main menu.'
      main_menu(hotel, room_tracker, guest_list)
    else
      puts ' '
      puts "There are #{room_tracker.rooms_available} rooms available. Enter '1' to return to main menu or enter name of new guest: "
      puts ' '
      new_guest = gets.chomp
      if new_guest.to_i == 1
        main_menu(hotel, room_tracker, guest_list)
      else manager_process_check_in_request_rooms(new_guest, hotel, guest_list, room_tracker)
      end
    end
  end

  def manager_process_check_in_request_rooms(new_guest, hotel, guest_list, room_tracker)
    puts ' '
    puts "There are #{room_tracker.rooms_available} rooms available. Enter '0' to return to main menu or enter number of rooms required by #{new_guest}: "
    puts ' '
    num_of_rooms = gets.chomp.to_i
    if num_of_rooms == 0
      main_menu(hotel, room_tracker, guest_list)
    elsif num_of_rooms > room_tracker.rooms_available || num_of_rooms < 0
      puts ' '
      puts "Invalid response entered."
      manager_process_check_in_request_rooms(new_guest, hotel, guest_list, room_tracker)
    else guest = Guest.new(new_guest, num_of_rooms)
      guest.change_guest_rooms(num_of_rooms)
      guest_list.add_guest(guest)
      room_tracker.assign_room_to_guest(guest.name, num_of_rooms)
      puts ' '
      puts "Check-in of #{guest.name} confirmed. View rooms and occupants from main menu (option 4) to see room number(s) registered to #{guest.name}."
      main_menu(hotel, room_tracker, guest_list)
    end
  end


end



manager = Manager.new
hotel = Hotel.new('My Hotel', 12, 50)
room_tracker = RoomTracker.new(12)
guest_list = GuestList.new


manager.main_menu(hotel, room_tracker, guest_list)














