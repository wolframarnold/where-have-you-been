require 'spec_helper'

describe 'layouts/application' do
  include Devise::TestHelpers

  context 'when signed out' do
    before do
      render :template => 'layouts/application'
    end

    it 'shows sign in link' do
      rendered.should have_tag("a[href='#{new_user_session_path}']", :text => 'Sign In')
    end
    it 'shows sign up link' do
      rendered.should have_tag("a[href='#{new_user_registration_path}']", :text => 'Sign Up')
    end
    it 'does not show sign_out link' do
      rendered.should_not have_tag("a[href='#{destroy_user_session_path}']")
    end
  end

  context 'when signed in' do
    before do
      @user = FactoryGirl.create(:user)
      sign_in @user
      render :template => 'layouts/application'
    end

    it 'shows sign_out link' do
      rendered.should have_tag("a[href='#{destroy_user_session_path}']")
    end
    it 'does not show sign_in link' do
      rendered.should_not have_tag("a[href='#{new_user_session_path}']", :text => 'Sign In')
    end
    it 'does not show sign_up button' do
      rendered.should_not have_tag("a[href='#{new_user_registration_path}']", :text => 'Sign Up')
    end
  end

end
