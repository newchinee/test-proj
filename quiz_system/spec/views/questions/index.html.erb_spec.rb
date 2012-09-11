require 'spec_helper'

describe "questions/index" do
  before(:each) do
    assign(:questions, [
      stub_model(Question,
        :detail => "Detail",
        :quiz_id => 1,
        :score_integer => "Score Integer",
        :deleted_flag => false
      ),
      stub_model(Question,
        :detail => "Detail",
        :quiz_id => 1,
        :score_integer => "Score Integer",
        :deleted_flag => false
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detail".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Score Integer".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
