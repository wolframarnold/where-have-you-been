require 'spec_helper'

describe Place do

  it 'cannot mass-assign trip_id' do
    place = Place.new(:trip_id => 123)
    place.trip_id.should be_nil
  end

  context 'Validations' do
    %w(trip name).each do |attr|
      it "requires a #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end
  end

  context 'Trip Association' do
    it 'responds_to trip' do
      should respond_to(:trip)
    end
    it 'can retrieve a trip' do
      place = FactoryGirl.create(:place)
      place.trip.should be_kind_of(Trip)
    end
  end
end
