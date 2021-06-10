class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 2
  attr_reader :balance
  attr_reader :exit_station
  attr_reader :entry_station
  attr_reader :journey_history
  
  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(sum)
    fail "£#{MAXIMUM_BALANCE} limit" if (@balance + sum) > MAXIMUM_BALANCE
    @balance += sum
  end

  def touch_in(entry_station)
    fail "Insufficient funds. Please top up" if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
    @exit_station = nil
  end

  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
    @exit_station = exit_station
  end

  def in_journey?
    !!entry_station
  end

  def journeys

  end

  private
  def deduct(fare)
    @balance -= fare
  end
end