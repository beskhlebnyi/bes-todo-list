require 'rails_helper'

RSpec.feature "Tasks", type: :feature, js: true do
  
  before do
    create(:list, title: "some list")
    @task = create(:task, :with_list, id: 999)
  end

  scenario "user create a new task" do
    visit root_path

    expect {
      click_link "some list"
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
    click_link @task.list.title
    
    within "#task-#{@task.id}" do
      click_link "Edit"
    end
    
    fill_in "Content", with: "some new task"
    check "Status"
    check "Important"
    click_button "Update Task"
    visit root_path
    click_link @task.list.title
    
    expect(page).to have_content("some new task")
  end
end
