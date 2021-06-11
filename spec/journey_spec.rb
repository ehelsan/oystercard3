require 'journey'
require 'oystercard'

describe Journey do
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }
  let(:oystercard) { Oystercard.new }  
  let(:journey) { Journey.new(oystercard) }

  
  it 'stores the entry station' do
    oystercard.top_up(Journey::MINIMUM_BALANCE)
    journey.touch_in(entry_station)
    expect(journey.entry_station).to eq entry_station
  end  

  it 'stores the exit station' do
    oystercard.top_up(Journey::MINIMUM_BALANCE)
    journey.touch_in(entry_station)
    journey.touch_out(exit_station)
    expect(journey.exit_station).to eq exit_station
  end

  describe '#touch_in' do
    it 'doesn\'t allow travel if balance lower than £1' do
      expect{ journey.touch_in('')}.to raise_error "Insufficient funds. Please top up"
    end
  end


  describe '#in_journey?' do
    it 'is initially not in a journey' do   
      expect(journey).not_to be_in_journey
    end
  end

  it 'it can touch in' do
    oystercard.top_up(1)
    journey.touch_in(entry_station)
    expect(journey).to be_in_journey
  end
  it "can touch out" do
    oystercard.top_up(1)
    journey.touch_in(entry_station)
    journey.touch_out(exit_station)
    expect(journey).not_to be_in_journey
  end

  it 'has an empty journey history by default' do
    expect(journey.journey_history).to be_empty
  end

  it 'has a history of journeys' do 
    oystercard.top_up(10)
    journey.touch_in(entry_station)
    journey.touch_out(exit_station)
    journey.journeys
    expect(journey.journey_history).not_to be_empty
  end

end