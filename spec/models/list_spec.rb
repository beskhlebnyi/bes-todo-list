require 'rails_helper'

RSpec.describe List, type: :model do
  
  it "has a valid factory" do
    expect(build(:list)).to be_valid
  end

  it "is invalid without a title" do
    list = build(:list, title: nil)
    list.valid?
    expect(list.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a duplicate title" do
    old_list = create(:list)
    list = build(:list, title: old_list.title, user: old_list.user)
    list.valid?
    expect(list.errors[:title]).to include("has already been taken")
  end
end
