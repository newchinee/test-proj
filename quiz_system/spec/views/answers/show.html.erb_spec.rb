require 'spec_helper'

describe "answers/show" do
  before(:each) do
    @answer = assign(:answer, stub_model(Answer,
      :detail => "Detail",
      :question_id => 1,
      :correct_flag => false,
      :score => 2,
      :explanation => "MyText",
      :deleted_flag => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detail/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
    rendered.should match(/false/)
  end
end
