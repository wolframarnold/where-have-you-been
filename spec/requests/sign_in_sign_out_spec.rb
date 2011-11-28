require 'spec_helper'
require 'capybara/rspec'

describe "User Sign In, Sign Out" do
  before do
    @trip = FactoryGirl.create(:trip)
    @user = @trip.user
  end

  it "can sign in and is redirected to home page" do
    visit new_user_session_path
    current_path.should == '/users/sign_in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    current_path.should == "/trips"
    page.should have_content("Sign Out")
  end

  it "can sign out" do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    click_link 'Sign Out'
    current_path.should == '/'
    page.should have_content("Sign In")
  end

end
