require 'spec_helper'

describe "questions/show" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :detail => "Detail",
      :quiz_id => 1,
      :score_integer => "Score Integer",
      :deleted_flag => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detail/)
    rendered.should match(/1/)
    rendered.should match(/Score Integer/)
    rendered.should match(/false/)
  end
end
