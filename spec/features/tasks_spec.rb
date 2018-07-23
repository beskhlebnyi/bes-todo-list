require 'rails_helper'

RSpec.feature "Documents", type: :feature, js: true do
  let (:list) { create(:list) }
  let!(:document) { create(:document, list: list) }

  before do
    sign_in document.list.user
  end

  scenario "user create a new document" do
    visit root_path

    expect {
      click_link document.list.title
      click_link "New Document"
      fill_in "Content", with: "some document"
      fill_in "Deadline",	with: "#{DateTime.tomorrow}"
      find(:css, "#status-checkbox").set(true)
      find(:css, "#important-checkbox").set(true)
      click_button "Save"
      sleep 3
      visit root_path
    }.to change(Document.all, :count).by(1)
    
    click_link document.list.title

    expect(page).to have_content("some document")
  end

  context "with empty content" do
    scenario "user can't create a new document" do
      visit root_path
  
      expect {
        click_link document.list.title
        click_link "New Document"
        fill_in "Content", with: ""
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.not_to change(Document.all, :count)

      click_button "Close"
      click_link document.list.title
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content can't be blank")
    end

    scenario "user can't update a document" do
      visit root_path
  
      expect {
        click_link document.list.title
        find("#document-#{document.id}").hover.click_on class: 'fa-edit'
        fill_in "Content", with: ""
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.to_not change(Document.all, :count)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content can't be blank")
    end
  end

  context "with same content" do
    scenario "user can't create a new document" do
      old_content = document.content
      visit root_path
  
      expect {
        click_link document.list.title
        click_link "New Document"
        fill_in "Content", with: document.content
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.not_to change(Document.all, :count)
      
      click_button "Close"
      click_link document.list.title

      expect(document.content).to include(old_content)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content has already been taken")
    end

  end

  scenario "user edit a document" do
    visit root_path
    click_link document.list.title
    find("#document-#{document.id}").hover.click_on class: 'fa-edit'
    fill_in "Content", with: "some new document"
    find(:css, "#status-checkbox").set(true)
    find(:css, "#important-checkbox").set(true)
    click_button "Save"
    click_link document.list.title
    
    expect(page).to have_content("some new document")
  end

  scenario "user delete a document" do
    visit root_path
    click_link document.list.title
    find("#document-#{document.id}").hover.click_on class: 'fa-trash'
    page.driver.browser.switch_to.alert.accept
    click_link document.list.title
    
    expect(page).not_to have_content(document.content)
  end

end
