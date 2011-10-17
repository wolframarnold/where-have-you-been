require 'spec_helper'

describe Trip do

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

  context 'Association' do
    it 'responds_to user' do
      should respond_to(:user)
    end
    it 'can retrieve a user' do
      trip = FactoryGirl.create(:trip)
      trip.user.should be_kind_of(User)
    end
  end
end
