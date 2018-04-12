require 'rails_helper'

RSpec.feature "Tasks", type: :feature, js: true do
  let!(:task) { create(:task, :with_list) }

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
    visit root_path
    click_link task.list.title
    
    expect(page).to have_content("some new task")
  end

  scenario "user delete a task" do
    visit root_path
    click_link task.list.title
    
    within "#task-#{task.id}" do
      click_link "Destroy"
    end
    
    visit root_path
    click_link task.list.title
    
    expect(page).not_to have_content(task.content)
  end

  scenario "user show a task" do
    visit root_path
    click_link task.list.title
    click_link task.content

    expect(page).to have_content("Task")
    expect(page).to have_content("Content:#{task.content}")
  end
end
