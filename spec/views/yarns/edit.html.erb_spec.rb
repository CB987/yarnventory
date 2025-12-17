require 'rails_helper'

RSpec.describe "yarns/edit", type: :view do
  let(:yarn) {
    Yarn.create!(
      title: "MyString"
    )
  }

  before(:each) do
    assign(:yarn, yarn)
  end

  it "renders the edit yarn form" do
    render

    assert_select "form[action=?][method=?]", yarn_path(yarn), "post" do

      assert_select "input[name=?]", "yarn[title]"
    end
  end
end
