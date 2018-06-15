require 'rails_helper'

RSpec.feature "Lists", type: :feature, js: true do
  let!(:list) { create(:list, title: "Some list") }

  before do
    sign_in list.user
  end
  
  scenario "user create a new list" do
    visit root_path
    
    expect{
      click_link "New List"
      find('#mainModal', :visible => false)
      fill_in "Title", with: "some new list"
      click_button "Create List"
      
      visit root_path
    }.to change(List.all, :count).by(1)
    
    visit root_path

    expect(page).to have_content "some new list"
  end

  context "with a empty title" do
    scenario "user can't create new list" do
      visit root_path

      expect{
        click_link "New List"
        fill_in "Title", with: ""
        click_button "Create List"
      }.not_to change(List.all, :count)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content "Title can't be blank"
    end

    scenario "user can't update a list" do
      old_title = list.title
      visit root_path

      within "#list-#{list.id}" do
        click_on class: 'fa-edit'
      end

      fill_in "Title", with: ""
      click_button "Update List"
      
      expect(list.title).to include(old_title)

      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content "Title can't be blank"
    end
  end

  context "with same title" do
    scenario "user can't create new list" do
      create(:list, title: "same title", user: list.user)
      visit root_path

      expect{
        click_link "New List"
        fill_in "Title", with: "same title"
        click_button "Create List"
      }.not_to change(List.all, :count)

      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content "Title has already been taken"
    end

    scenario "user can't update list" do
      old_title = list.title
      create(:list, title: "same title", user: list.user)
      visit root_path

      within "#list-#{list.id}" do
        click_on class: 'fa-edit'
      end

      fill_in "Title", with: "same title"
      click_button "Update List"
      
      expect(list.title).to include(old_title)

      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content "Title has already been taken"
    end
  end

  scenario "user show list of tasks" do
    visit root_path
    click_link "Some list"
    
    expect(page).to have_content "Your tasks"
  end

  scenario "user delete a list" do
    visit root_path

    expect {
      click_on class: 'fa-trash'
      visit root_path
    }.to change(List.all, :count).by(-1)

    visit root_path

    expect(page).not_to have_content(list.title)
  end

  scenario "user update a list" do
    visit root_path
    click_on class: 'fa-edit'
    within('#mainModal') do
      fill_in "Title", with: "Edited list"
      click_button "Update List"
    end
    # TODO: Uncomment this after notice refactor:
    # expect(page).to have_content "List was successfully updated."
    expect(page).to have_content "Edited list"
  end
end