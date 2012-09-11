require 'spec_helper'

describe "results/show" do
  before(:each) do
    @result = assign(:result, stub_model(Result,
      :user_id => 1,
      :quiz_id => 2,
      :marks => 3,
      :comment => "MyText",
      :retry_count => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
    rendered.should match(/4/)
  end
end
