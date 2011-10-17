require 'spec_helper'

describe "trips/index.html.haml" do
  before(:each) do
    assign(:trips, [
      stub_model(Trip,
        :name => "Name",
        :user => nil
      ),
      stub_model(Trip,
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of trips" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
