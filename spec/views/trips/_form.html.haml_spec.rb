require 'spec_helper'

describe 'trips/_form' do

  shared_examples_for 'input form' do
    it 'should have an input field for name' do
      rendered.should have_tag "form[action='#{@url}']"
    end
    it 'should have a form posting to /trips' do
      rendered.should have_tag "input[name='trip[name]']"
    end
  end

  shared_examples_for 'input form with errors' do
    it 'should show missing name error' do
      rendered.should have_tag('.field_with_errors', :text => /can.t be blank/) # Nokogiri seems to have trouble when matching a regex that contains an apostrophe (')
    end
  end

  context 'new' do
    it_behaves_like 'input form' do
      before do
        @trip = Trip.new
        @url = trips_path
        render
      end
    end
    it_behaves_like 'input form with errors' do
      before do
        @trip = Trip.new
        @trip.should_not be_valid # will cause errors to be populated
        render
      end
    end
  end

  context 'edit' do
    it_behaves_like 'input form' do
      before do
        @trip = FactoryGirl.create(:trip)
        @url = trip_path(@trip)
        render
      end
    end
  end
end
