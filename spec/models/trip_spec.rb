require 'spec_helper'

describe Trip do

  it 'cannot mass-assign user' do
    trip = Trip.new(:user_id => 123)
    trip.user_id.should be_nil
  end

  context 'Validation' do
    it 'must have a name' do
      should_not be_valid
      subject.errors[:name].should_not be_empty
    end
    it 'must have a user' do
      should_not be_valid
      subject.errors[:user].should_not be_empty
    end
  end

  context 'User Association' do
    it 'responds_to user' do
      should respond_to(:user)
    end
    it 'can retrieve a user' do
      trip = FactoryGirl.create(:trip)
      trip.user.should be_kind_of(User)
    end
  end

  context 'Places Association' do
    it 'responds to places' do
      should respond_to(:places)
    end
    it 'can create a place' do
      trip = FactoryGirl.create(:trip)
      expect {
        trip.places.create(:name => 'Hello World!')
      }.should change(trip.places,:count).by(1)
    end
    it 'will remove dependents' do
      place = FactoryGirl.create(:place)
      place.should be_persisted
      trip = place.trip
      expect {
        trip.destroy
      }.to change(Place,:count).by(-1)
    end
  end

  context 'nested_attributes_for :places' do
    it 'can create a trip with a place' do
      expect {
      expect {
        trip = Trip.new(name: 'SoCal', places_attributes: [{name: 'LA'},{name: 'Anaheim'}])
        trip.user = FactoryGirl.create(:user)
        trip.should have(2).places
        trip.save!
      }.should change(Trip,:count).by(1)
      }.should change(Place,:count).by(2)
    end
  end

end
