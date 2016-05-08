class GuestList

  attr_accessor(:list)

  def initialize
    @list = []
  end

  def add_guest(guest)
    @list.push(guest)
  end

  def remove_guest(guest)
    @list.delete_if {|guest_in_list| guest_in_list.name == guest.name}
  end

end