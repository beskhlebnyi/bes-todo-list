require 'rails_helper'

RSpec.feature "Tasks", type: :feature, js: true do
  let (:list) { create(:list) }
  let!(:task) { create(:task, list: list) }

  before do
    sign_in task.list.user
  end

  scenario "user create a new task" do
    visit root_path

    expect {
      click_link task.list.title
      click_link "New Task"
      fill_in "Content", with: "some task"
      fill_in "Deadline",	with: "#{DateTime.tomorrow}"
      find("#status-checkbox").set(true)
      find("#important-checkbox").set(true)
      click_button "Save"
      sleep 1
      visit root_path
    }.to change(Task.all, :count).by(1)
    
    click_link task.list.title

    expect(page).to have_content("some task")
  end

  scenario "user edit a task" do
    visit root_path
    click_link task.list.title
    find("#task-#{task.id}").hover.click_on class: 'fa-edit'
    fill_in "Content", with: "some new task"
    find("#status-checkbox").set(true)
    find("#important-checkbox").set(true)
    click_button "Save"
    sleep 1
    click_link task.list.title
    
    expect(page).to have_content("some new task")
  end

  context "with empty content" do
    scenario "user can't create a new task" do
      visit root_path
  
      expect {
        click_link task.list.title
        click_link "New Task"
        fill_in "Content", with: ""
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.not_to change(Task.all, :count)

      click_button "Close"
      click_link task.list.title
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content can't be blank")
    end

    scenario "user can't update a task" do
      visit root_path
  
      expect {
        click_link task.list.title
        find("#task-#{task.id}").hover.click_on class: 'fa-edit'
        fill_in "Content", with: ""
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.to_not change(Task.all, :count)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content can't be blank")
    end
  end

  context "with same content" do
    scenario "user can't create a new task" do
      old_content = task.content
      visit root_path
  
      expect {
        click_link task.list.title
        click_link "New Task"
        fill_in "Content", with: task.content
        find(:css, "#status-checkbox").set(true)
        find(:css, "#important-checkbox").set(true)
        click_button "Save"
      }.not_to change(Task.all, :count)
      
      click_button "Close"
      click_link task.list.title

      expect(task.content).to include(old_content)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content has already been taken")
    end

  end

  scenario "user delete a task" do
    visit root_path
    click_link task.list.title
    find("#task-#{task.id}").hover.click_on class: 'fa-trash'
    page.driver.browser.switch_to.alert.accept
    click_link task.list.title
    
    expect(page).not_to have_content(task.content)
  end

end
