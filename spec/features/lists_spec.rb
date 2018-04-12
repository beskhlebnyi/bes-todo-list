require 'rails_helper'

RSpec.feature "Lists", type: :feature, js: true do
  let!(:list) { create(:list, title: "Some list") }
  
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

  context "with a empty title" do
    scenario "user can't create new list" do
      visit root_path

      expect{
        click_link "New List"
        fill_in "Title", with: ""
        click_button "Create List"
      }.not_to change(List.all, :count)
  
      expect(page).to have_content "Title can't be blank"
    end

    scenario "user can't update a list" do
      visit root_path

      within "#list-#{list.id}" do
        click_link "Edit" 
      end

      fill_in "Title", with: ""
      click_button "Update List"
      
      expect(page).to have_content "Title can't be blank"
    end
  end

  context "with same title" do
    scenario "user can't create new list" do
      create(:list, title: "same title")
      visit root_path

      expect{
        click_link "New List"
        fill_in "Title", with: "same title"
        click_button "Create List"
      }.not_to change(List.all, :count)
  
      expect(page).to have_content "Title has already been taken"
    end

    scenario "user can't update list" do
      create(:list, title: "same title")
      visit root_path

      within "#list-#{list.id}" do
        click_link "Edit" 
      end

      fill_in "Title", with: "same title"
      click_button "Update List"
      
      expect(page).to have_content "Title has already been taken"
    end
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

    expect(page).not_to have_content(list.title)
  end

  scenario "user update a list" do
    visit root_path
    click_link "Edit"
    fill_in "Title", with: "Edited list"
    click_button "Update List"
    
    expect(page).to have_content "List was successfully updated."
    expect(page).to have_content "Edited list"
  end
end