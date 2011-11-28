require 'spec_helper'

describe 'trips/index' do
  before do
    @trip = FactoryGirl.create(:trip)
    assign(:latest_trip, @trip)
    assign(:trips, [@trip])
    render
  end

  it 'contains first trip name as h2' do
    rendered.should have_tag('h2', text: @trip.name)
  end

end
