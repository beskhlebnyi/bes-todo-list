require 'rails_helper'

RSpec.describe Task, type: :model do
  it "has a valid factory" do
    expect(build(:task, :with_list)).to be_valid
  end

  it "is invalid without content" do
    task = build(:task, :with_list, content: nil)
    task.valid?
    expect(task.errors[:content]).to include("can't be blank")
  end

  it "is invalid with a duplicate content in one list" do
    list = create(:list, title: "some title")
    create(:task, content: "some content", list: list)
    task = build(:task, content: "some content", list: list)
    task.valid?
    expect(task.errors[:content]).to include("has already been taken")
  end
end
