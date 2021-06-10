require 'oystercard'

describe Oystercard do
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }
  
  it 'stores the entry station' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
  end  

  it 'stores the exit station' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'checks if no money on card' do
    expect(subject.balance).to eq(0)
  end
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
    it 'doesn\'t allow excession of £90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_error "£#{maximum_balance} limit"
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it 'doesn\'t allow travel if balance lower than £1' do
      expect{ subject.touch_in('')}.to raise_error "Insufficient funds. Please top up"
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out)}

    it 'deduct balance' do
      expect {subject.touch_out(exit_station)}.to change{subject.balance}.by (-Oystercard::MINIMUM_CHARGE)
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?)}
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  it 'it can touch in' do
    subject.top_up(1)
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
  end
  it "can touch out" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end

  it 'has an empty journey history by default' do
    expect(subject.journey_history).to be_empty
  end
  

end
