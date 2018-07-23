require 'rails_helper'

RSpec.feature "Files", type: :feature, js: true do
  let (:list) { create(:list) }
  let!(:file) { create(:file, list: list) }

  before do
    sign_in file.list.user
  end

  scenario "user create a new file" do
    visit root_path

    expect {
      click_link file.list.title
      click_link "New File"
      fill_in "Content", with: "some file"
      fill_in "Deadline",	with: "#{DateTime.tomorrow}"
      find(:css, "#status-checkbox").set(true)
      find(:css, "#important-checkbox").set(true)
      click_button "Save"
      sleep 3
      visit root_path
    }.to change(File.all, :count).by(1)
    
    click_link file.list.title

    expect(page).to have_content("some file")
  end

  context "with empty content" do
    scenario "user can't create a new file" do
      visit root_path
  
      expect {
        click_link file.list.title
        click_link "New File"
        fill_in "Content", with: ""
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.not_to change(File.all, :count)

      click_button "Close"
      click_link file.list.title
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content can't be blank")
    end

    scenario "user can't update a file" do
      visit root_path
  
      expect {
        click_link file.list.title
        find("#file-#{file.id}").hover.click_on class: 'fa-edit'
        fill_in "Content", with: ""
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.to_not change(File.all, :count)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content can't be blank")
    end
  end

  context "with same content" do
    scenario "user can't create a new file" do
      old_content = file.content
      visit root_path
  
      expect {
        click_link file.list.title
        click_link "New File"
        fill_in "Content", with: file.content
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.not_to change(File.all, :count)
      
      click_button "Close"
      click_link file.list.title

      expect(file.content).to include(old_content)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content has already been taken")
    end

  end

  scenario "user edit a file" do
    visit root_path
    click_link file.list.title
    find("#file-#{file.id}").hover.click_on class: 'fa-edit'
    fill_in "Content", with: "some new file"
    find(:css, "#status-checkbox").set(true)
    find(:css, "#important-checkbox").set(true)
    click_button "Save"
    click_link file.list.title
    
    expect(page).to have_content("some new file")
  end

  scenario "user delete a file" do
    visit root_path
    click_link file.list.title
    find("#file-#{file.id}").hover.click_on class: 'fa-trash'
    page.driver.browser.switch_to.alert.accept
    click_link file.list.title
    
    expect(page).not_to have_content(file.content)
  end

end
