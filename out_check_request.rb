require_relative('guest')

class CheckOutRequest

  attr_reader(:guest_name, :amount_owed)

def initialize(guest_name, amount_owed)
  @guest_name = guest_name
  @amount_owed = amount_owed
end

end