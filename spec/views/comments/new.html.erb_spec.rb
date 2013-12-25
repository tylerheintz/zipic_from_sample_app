require 'spec_helper'

describe "comments/new" do
  before(:each) do
    assign(:comment, stub_model(Comment,
      :content => "MyString",
      :user_id => 1,
      :micropost_id => 1,
      :rating => 1
    ).as_new_record)
  end

  it "renders new comment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", comments_path, "post" do
      assert_select "input#comment_content[name=?]", "comment[content]"
      assert_select "input#comment_user_id[name=?]", "comment[user_id]"
      assert_select "input#comment_micropost_id[name=?]", "comment[micropost_id]"
      assert_select "input#comment_rating[name=?]", "comment[rating]"
    end
  end
end
