require 'spec_helper'

describe Trip do

  it 'cannot mass-assign user' do
    trip = Trip.new(:user_id => 123)
    trip.user_id.should be_nil
  end

  it 'can mass-assign begun_on, ended_on' do
    trip = Trip.new(:begun_on => Date.yesterday, :ended_on => Date.today)
    trip.begun_on.should_not be_nil
    trip.ended_on.should_not be_nil
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
    it 'must have ended_on if begun_on is set' do
      subject.begun_on = Date.yesterday
      subject.should_not be_valid
      subject.errors[:ended_on].should_not be_blank
    end
    it 'must have begun_on if ended_on is set' do
      subject.ended_on = Date.yesterday
      subject.should_not be_valid
      subject.errors[:begun_on].should_not be_blank
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

  context "as_json" do
    before do
      @jan1 = Time.utc(2011,1,1)
      Time.stub!(:now).and_return(@jan1)
      @trip = FactoryGirl.create(:trip_with_places)
    end

    it 'returns trips with places' do
      @trip.as_json.should have_key(:places)
      @trip.as_json[:places].should be_a(Array)
      @trip.as_json[:places].first.should include('name' => 'Cuzco')
    end

  end

end
