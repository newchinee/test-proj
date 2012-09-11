require 'spec_helper'

describe "quizzes/new" do
  before(:each) do
    assign(:quiz, stub_model(Quiz,
      :name => "MyString",
      :description => "MyText",
      :category_id => 1,
      :random_flag => false,
      :max_question => 1,
      :deleted_flag => false
    ).as_new_record)
  end

  it "renders new quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => quizzes_path, :method => "post" do
      assert_select "input#quiz_name", :name => "quiz[name]"
      assert_select "textarea#quiz_description", :name => "quiz[description]"
      assert_select "input#quiz_category_id", :name => "quiz[category_id]"
      assert_select "input#quiz_random_flag", :name => "quiz[random_flag]"
      assert_select "input#quiz_max_question", :name => "quiz[max_question]"
      assert_select "input#quiz_deleted_flag", :name => "quiz[deleted_flag]"
    end
  end
end
