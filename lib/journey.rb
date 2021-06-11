
class Journey

  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 2
  attr_reader :exit_station
  attr_reader :entry_station
  attr_reader :journey_history

  def initialize(oystercard)
    @oystercard = oystercard
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def touch_in(entry_station)
    fail "Insufficient funds. Please top up" if @oystercard.balance < MINIMUM_BALANCE
    @exit_station = nil
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @oystercard.deduct(MINIMUM_CHARGE)
    @exit_station = exit_station
    journeys
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def journeys
    journey = {
      "entry" => entry_station,
      "exit" => exit_station
    }
    @journey_history << journey
  end



end