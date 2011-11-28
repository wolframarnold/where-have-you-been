require 'spec_helper'
require 'capybara/rspec'

describe "Smoke Test: As a user, I can", :js => true do  # This will launch selenium driver by default, see Capybara README for details
  before :all do
    # Use before :all to avoid including the user into the RSpec transactional scope, otherwise the test won't see the user
    # For details see: "Transactional fixtures" section and thread referenced therein: https://groups.google.com/forum/#!msg/ruby-capybara/JI6JrirL9gM/R6YiXj4gi_UJ
    @user = FactoryGirl.create(:user, password: 'password', password_confirmation: 'password')
  end
  after :all do
    @user.destroy  # need to clean up manually, as before :all is not governed by RSpec's transactional scope
  end
  it 'log in, create a trip with places and view the map' do
    visit(new_user_session_path)
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    current_path.should == trips_path
    click_link 'New Trip'
    fill_in 'Name', with: 'West Coast'
    fill_in 'Place/City', with: 'Los Angeles'  # This will find the first field, use XPATH or CSS locator to access other fields with name label
    click_button 'Save'
    current_path.should match(%r{trips/\d+})
    page.should have_css('div#map')
  end
end
