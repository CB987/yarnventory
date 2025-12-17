require 'rails_helper'

RSpec.describe "yarns/index", type: :view do
  before(:each) do
    assign(:yarns, [
      Yarn.create!(
        title: "Title"
      ),
      Yarn.create!(
        title: "Title"
      )
    ])
  end

  it "renders a list of yarns" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
  end
end
