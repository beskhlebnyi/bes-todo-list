require 'rails_helper'

RSpec.feature "Lists", type: :feature do
  scenario "guest creates a new list",  js: true do
    visit root_path
    
    expect{
      click_link "New List"
      fill_in "Title", with: "some list"
      click_button "Create List"
      visit root_path
    }.to change(List.all, :count).by(1)

    expect(page).to have_content "some list"
  end
end
