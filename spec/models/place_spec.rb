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

  it_behaves_like 'belongs_to association', 'place', 'trip'
end
