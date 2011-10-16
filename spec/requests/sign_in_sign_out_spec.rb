require 'spec_helper'

describe "User Sign In, Sign Out" do
  before do
    @user = FactoryGirl.create(:user)
  end
  it "can sign in and is redirected to home page" do
    visit new_user_session_path
    response.status.should be(200)
    fill_in 'email', with: @user.email
    fill_in 'password', with: 'password'
    click_button 'Sign in'
    current_url.should == 'http://www.example.com/'
    response.should contain("Sign Out")
  end

  it "can sign out" do
    visit new_user_session_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: 'password'
    click_button 'Sign in'
    click_link 'Sign Out'
    current_url.should == 'http://www.example.com/'
    response.should contain("Sign In")
  end

end
