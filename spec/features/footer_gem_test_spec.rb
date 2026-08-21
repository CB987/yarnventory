# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "visit page, there's a footer", type: :feature do
  # is the footer placed?
  it 'has a footer' do
    visit root_path
    expect(page).to have_selector("#emory-footer")
  end

  # and are the links in place?
  it 'footer has links' do
    visit root_path
    expect(page).to have_selector(".footer-list")
  end

  # can haz selenium test?
  # are the styles applied?
  it 'footer is emory blue', js: true do
    visit root_path
    expect(page.find('#emory-footer footer')).to match_style('background-color' => 'rgb(9, 28, 68)')
  end
end

# test that the version line is pulling variables
RSpec.describe "version is displaying correctly", type: :feature do
  it "shows the version information in the footer" do
    stub_const("BRANCH", "branchy-mcversionface")
    stub_const("LAST_DEPLOYED", "when it is a damp drizzly november in my soul")

    visit root_path
    expect(page.find('#emory-footer')).to have_content("Version branchy-mcversionface updated when it is a damp drizzly november in my soul")
  end
end