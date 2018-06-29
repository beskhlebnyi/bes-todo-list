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

end
