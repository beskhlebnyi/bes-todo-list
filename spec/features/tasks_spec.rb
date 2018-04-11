require 'rails_helper'

RSpec.feature "Tasks", type: :feature, js: true do
  before do
    create(:list, title: "some list")
    create(:task, :with_list)
  end

  scenario "user create a new task" do
    visit root_path

    expect{
      click_link "some list"
      click_link "New Task"
      fill_in "Content", with: "some task"
      check "Status"
      check "Important"
      click_button "Create Task"
      visit root_path
  }.to change(Task.all, :count).by(1)

  end

end
