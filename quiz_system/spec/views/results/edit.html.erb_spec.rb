require 'spec_helper'

describe "results/edit" do
  before(:each) do
    @result = assign(:result, stub_model(Result,
      :user_id => 1,
      :quiz_id => 1,
      :marks => 1,
      :comment => "MyText",
      :retry_count => 1
    ))
  end

  it "renders the edit result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => results_path(@result), :method => "post" do
      assert_select "input#result_user_id", :name => "result[user_id]"
      assert_select "input#result_quiz_id", :name => "result[quiz_id]"
      assert_select "input#result_marks", :name => "result[marks]"
      assert_select "textarea#result_comment", :name => "result[comment]"
      assert_select "input#result_retry_count", :name => "result[retry_count]"
    end
  end
end
