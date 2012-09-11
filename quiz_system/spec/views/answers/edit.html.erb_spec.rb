require 'spec_helper'

describe "answers/edit" do
  before(:each) do
    @answer = assign(:answer, stub_model(Answer,
      :detail => "MyString",
      :question_id => 1,
      :correct_flag => false,
      :score => 1,
      :explanation => "MyText",
      :deleted_flag => false
    ))
  end

  it "renders the edit answer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => answers_path(@answer), :method => "post" do
      assert_select "input#answer_detail", :name => "answer[detail]"
      assert_select "input#answer_question_id", :name => "answer[question_id]"
      assert_select "input#answer_correct_flag", :name => "answer[correct_flag]"
      assert_select "input#answer_score", :name => "answer[score]"
      assert_select "textarea#answer_explanation", :name => "answer[explanation]"
      assert_select "input#answer_deleted_flag", :name => "answer[deleted_flag]"
    end
  end
end
