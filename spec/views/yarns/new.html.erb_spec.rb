require 'rails_helper'

RSpec.describe "yarns/new", type: :view do
  before(:each) do
    assign(:yarn, Yarn.new(
      title: "MyString"
    ))
  end

  it "renders new yarn form" do
    render

    assert_select "form[action=?][method=?]", yarns_path, "post" do

      assert_select "input[name=?]", "yarn[title]"
    end
  end
end
