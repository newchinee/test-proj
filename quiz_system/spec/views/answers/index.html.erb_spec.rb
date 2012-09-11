require 'spec_helper'

describe "answers/index" do
  before(:each) do
    assign(:answers, [
      stub_model(Answer,
        :detail => "Detail",
        :question_id => 1,
        :correct_flag => false,
        :score => 2,
        :explanation => "MyText",
        :deleted_flag => false
      ),
      stub_model(Answer,
        :detail => "Detail",
        :question_id => 1,
        :correct_flag => false,
        :score => 2,
        :explanation => "MyText",
        :deleted_flag => false
      )
    ])
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detail".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
