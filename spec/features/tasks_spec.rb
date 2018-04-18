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
      check "Status"
      check "Important"
      click_button "Create Task"
      visit root_path
    }.to change(Task.all, :count).by(1)
    
    click_link task.list.title

    expect(page).to have_content("some task")
  end

  context "with empty content" do
    scenario "user can't create a new task" do
      visit root_path
  
      expect {
        click_link task.list.title
        click_link "New Task"
        fill_in "Content", with: ""
        check "Status"
        check "Important"
        click_button "Create Task"
      }.not_to change(Task.all, :count)
      
      click_link task.list.title

      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content can't be blank")
    end

    scenario "user can't update a task" do
      visit root_path
  
      expect {
        click_link task.list.title
        
        within "#task-#{task.id}" do
          click_link "Edit"
        end

        fill_in "Content", with: ""
        check "Status"
        check "Important"
        click_button "Update Task"
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
        check "Status"
        check "Important"
        click_button "Create Task"
      }.not_to change(Task.all, :count)
      
      click_link task.list.title

      expect(task.content).to include(old_content)
      
      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content has already been taken")
    end

    scenario "user can't update a task" do
      create(:task, content: "same content", list: task.list )
      old_content = task.content
      visit root_path
      click_link task.list.title
      
      within "#task-#{task.id}" do
        click_link "Edit"
      end

      fill_in "Content", with: "same content"
      check "Status"
      check "Important"
      click_button "Update Task"
      click_link task.list.title

      expect(task.content).to include(old_content)

      # TODO: Uncomment this after notice refactor:
      # expect(page).to have_content("Content has already been taken")
    end
  end

  scenario "user edit a task" do
    visit root_path
    click_link task.list.title
    
    within "#task-#{task.id}" do
      click_link "Edit"
    end
    
    fill_in "Content", with: "some new task"
    check "Status"
    check "Important"
    click_button "Update Task"
    click_link task.list.title
    
    expect(page).to have_content("some new task")
  end

  scenario "user delete a task" do
    visit root_path
    click_link task.list.title
    
    within "#task-#{task.id}" do
      click_link "Destroy"
    end
    
    click_link task.list.title
    
    expect(page).not_to have_content(task.content)
  end

end