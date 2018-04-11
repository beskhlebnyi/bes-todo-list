require 'rails_helper'

RSpec.feature "Lists", type: :feature, js: true do
  before do
    create(:list, title: "Some list")
  end
  
  scenario "user create a new list" do
    visit root_path
    
    expect{
      click_link "New List"
      fill_in "Title", with: "some list"
      click_button "Create List"
      visit root_path
    }.to change(List.all, :count).by(1)

    expect(page).to have_content "some list"
  end

  scenario "user show list of tasks" do
    visit root_path
    click_link "Some list"
    expect(page).to have_content "Listing tasks"
  end

  scenario "user delete a list" do
    visit root_path
    expect{
      click_link "Destroy"
      visit root_path
    }.to change(List.all, :count).by(-1)
  end

  scenario "user update a list" do
    visit root_path
    click_link "Edit"
    fill_in "Title", with: "Edited list"
    click_button "Update List"
    visit root_path
    expect(page).to have_content "Edited list"
  end
end
