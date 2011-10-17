require 'spec_helper'

describe "trips/new.html.haml" do
  before(:each) do
    assign(:trip, stub_model(Trip,
      :name => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new trip form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => trips_path, :method => "post" do
      assert_select "input#trip_name", :name => "trip[name]"
      assert_select "input#trip_user", :name => "trip[user]"
    end
  end
end
