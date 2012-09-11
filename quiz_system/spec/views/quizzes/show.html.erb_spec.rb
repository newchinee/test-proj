require 'spec_helper'

describe "quizzes/show" do
  before(:each) do
    @quiz = assign(:quiz, stub_model(Quiz,
      :name => "Name",
      :description => "MyText",
      :category_id => 1,
      :random_flag => false,
      :max_question => 2,
      :deleted_flag => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/2/)
    rendered.should match(/false/)
  end
end
