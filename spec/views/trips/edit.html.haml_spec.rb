require 'spec_helper'

describe "trips/edit.html.haml" do
  before(:each) do
    @trip = assign(:trip, stub_model(Trip,
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders the edit trip form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => trips_path(@trip), :method => "post" do
      assert_select "input#trip_name", :name => "trip[name]"
      assert_select "input#trip_user", :name => "trip[user]"
    end
  end
end
