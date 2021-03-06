require 'oystercard'

describe Oystercard do

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

  it 'can deduct balance' do
    expect {subject.deduct(1)}.to change{subject.balance}.by (-1)
  end

end
