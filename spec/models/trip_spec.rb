require 'spec_helper'

describe Trip do

  it 'cannot mass-assign user' do
    trip = Trip.new(:user_id => 123)
    trip.user_id.should be_nil
  end

  it 'returns trips in descending order' do
    trip_oldest = FactoryGirl.create(:trip, created_at: 1.year.ago)
    trip_older  = FactoryGirl.create(:trip, created_at: 1.month.ago)
    trip_recent = FactoryGirl.create(:trip, created_at: 1.day.ago)
    Trip.desc.first.should == trip_recent
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

  it_behaves_like 'belongs_to association', 'trip', 'user'
  it_behaves_like 'has_many association', 'trip', 'places'

  context 'nested_attributes_for :places' do
    it 'can create a trip with a place' do
      expect {
      expect {
        trip = FactoryGirl.create(:trip, places_attributes: [{name: 'LA'},{name: 'Anaheim'}])
        trip.should have(2).places
      }.should change(Trip,:count).by(1)
      }.should change(Place,:count).by(2)
    end
    it "ignores places with a blank name" do
      trip = FactoryGirl.create(:trip)
      expect {
        trip.places_attributes = [{name: ''}]
        trip.should have(0).places
        trip.should be_valid
        trip.save
      }.should_not change{trip.places.count}
    end
  end

end
