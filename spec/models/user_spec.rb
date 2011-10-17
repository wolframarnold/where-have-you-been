require 'spec_helper'

describe User do
  context 'Association' do
    it 'responds to trips' do
      should respond_to(:trips)
    end
    it 'can create a trip' do
      user = FactoryGirl.create(:user)
      expect {
        user.trips.create(:name => 'Hello World!')
      }.should change(user.trips,:count).by(1)
    end
    it 'will remove dependents' do
      trip = FactoryGirl.create(:trip)
      user = trip.user
      expect {
        user.destroy
      }.to change(Trip,:count).by(-1)
    end
  end
end
