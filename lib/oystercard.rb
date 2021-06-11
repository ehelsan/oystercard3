class Oystercard
  MAXIMUM_BALANCE = 90

  attr_reader :balance

  
  def initialize
    @balance = 0
  end

  def top_up(sum)
    fail "£#{MAXIMUM_BALANCE} limit" if (@balance + sum) > MAXIMUM_BALANCE
    @balance += sum
  end

  def deduct(fare)
    @balance -= fare
  end

end

