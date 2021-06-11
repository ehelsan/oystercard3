require 'station'

describe Station do
  station = Station.new("Oxford Street", 3)

  it 'responds to initialize method - name' do
    expect(station.name).to eq "Oxford Street"
  end

  it 'responds to initialize method - zone' do
    expect(station.zone).to eq 3
  end
end