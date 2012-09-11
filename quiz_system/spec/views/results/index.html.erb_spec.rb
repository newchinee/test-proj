require 'spec_helper'

describe "results/index" do
  before(:each) do
    assign(:results, [
      stub_model(Result,
        :user_id => 1,
        :quiz_id => 2,
        :marks => 3,
        :comment => "MyText",
        :retry_count => 4
      ),
      stub_model(Result,
        :user_id => 1,
        :quiz_id => 2,
        :marks => 3,
        :comment => "MyText",
        :retry_count => 4
      )
    ])
  end

  it "renders a list of results" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
