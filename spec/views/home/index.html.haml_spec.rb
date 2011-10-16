require 'spec_helper'

describe 'home/index' do
  include Devise::TestHelpers

  context 'when signed out' do
    before do
      render
    end
    it 'has a Sign Up button' do
      rendered.should have_form(new_user_registration_path, :get) do
        with_submit 'Sign Up'
      end
    end
  end

  context 'when signed in' do
    before do
      sign_in FactoryGirl.create(:user)
      render
    end
    it 'does not have a Sign Up button' do
      rendered.should_not have_tag('input[value="Sign Up"]')
    end
    it 'does not have a Sign In link' do
      rendered.should_not contain('Sign In')
    end
  end
end
