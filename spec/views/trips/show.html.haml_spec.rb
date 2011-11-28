require 'spec_helper'

describe 'trips/show' do
  before do
    @trip = FactoryGirl.create(:trip)
    assign(:trip, @trip)
    render
  end

  it 'contains trip name' do
    rendered.should have_tag('h2', text: @trip.name)
  end

end
