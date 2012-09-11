require 'spec_helper'

describe "questions/new" do
  before(:each) do
    assign(:question, stub_model(Question,
      :detail => "MyString",
      :quiz_id => 1,
      :score_integer => "MyString",
      :deleted_flag => false
    ).as_new_record)
  end

  it "renders new question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path, :method => "post" do
      assert_select "input#question_detail", :name => "question[detail]"
      assert_select "input#question_quiz_id", :name => "question[quiz_id]"
      assert_select "input#question_score_integer", :name => "question[score_integer]"
      assert_select "input#question_deleted_flag", :name => "question[deleted_flag]"
    end
  end
end
