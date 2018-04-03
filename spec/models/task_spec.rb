require 'rails_helper'

RSpec.describe Task, type: :model do
  
  it "has a valid factory" do
    expect(FactoryBot.build(:task)).to be_valid
  end

  it "is invalid without content" do
    task = FactoryBot.build(:task, content: nil)
    task.valid?
    expect(task.errors[:content]).to include("can't be blank")
  end

  it "is invalid with a duplicate content in one list" do
    list = FactoryBot.create(:list, title: "some title")
    FactoryBot.create(:task, content: "some content", list: list)
    task = FactoryBot.build(:task, content: "some content", list: list)
    task.valid?
    expect(task.errors[:content]).to include("has already been taken")
  end
end
